From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Mon, 08 Aug 2016 13:49:40 +0300
Subject: [PATCH V3 2/6] perf: Passing struct perf_event to function
 setup_aux()
In-Reply-To: <20160804171903.GV6862@twins.programming.kicks-ass.net>
References: <1469742143-22245-1-git-send-email-mathieu.poirier@linaro.org>
 <1469742143-22245-3-git-send-email-mathieu.poirier@linaro.org>
 <20160804171903.GV6862@twins.programming.kicks-ass.net>
Message-ID: <87mvknmt6j.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Thu, Jul 28, 2016 at 03:42:19PM -0600, Mathieu Poirier wrote:
>> Some information, like driver specific configuration, is found
>> in the hw_perf_event  structure.  As such pass a 'struct perf_event'
>> to function setup_aux() rather than just the CPU number so that
>> individual drivers can make the right configuration when setting
>> up a session.
>> 
>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>
> Yeah, no objection to this.

Sure, but I'd like a commit message that actually describes *what*
information and *why*.

Regards,
--
Alex
