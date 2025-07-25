package com.amazonaws.amplify.amplify_datastore

import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.test.resetMain
import kotlinx.coroutines.test.setMain
import kotlinx.coroutines.test.StandardTestDispatcher
import kotlinx.coroutines.test.TestDispatcher
import org.junit.rules.TestWatcher
import org.junit.runner.Description

/**
 * Test rule for running suspending tests on a common dispatcher. See [AtomicResultTest] for
 * an example.
 */
@ExperimentalCoroutinesApi
class CoroutineTestRule(val testDispatcher: TestDispatcher = StandardTestDispatcher()) :
    TestWatcher() {
    override fun starting(description: Description) {
        super.starting(description)
        Dispatchers.setMain(testDispatcher)
    }

    override fun finished(description: Description) {
        super.finished(description)
        Dispatchers.resetMain()
    }
}
