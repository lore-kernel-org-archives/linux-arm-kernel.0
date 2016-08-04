From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 4 Aug 2016 19:19:03 +0200
Subject: [PATCH V3 2/6] perf: Passing struct perf_event to function
 setup_aux()
In-Reply-To: <1469742143-22245-3-git-send-email-mathieu.poirier@linaro.org>
References: <1469742143-22245-1-git-send-email-mathieu.poirier@linaro.org>
 <1469742143-22245-3-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20160804171903.GV6862@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 28, 2016 at 03:42:19PM -0600, Mathieu Poirier wrote:
> Some information, like driver specific configuration, is found
> in the hw_perf_event  structure.  As such pass a 'struct perf_event'
> to function setup_aux() rather than just the CPU number so that
> individual drivers can make the right configuration when setting
> up a session.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>

Yeah, no objection to this.
