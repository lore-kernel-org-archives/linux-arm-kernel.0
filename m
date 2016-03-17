From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 18 Mar 2016 00:14:27 +0100
Subject: [PATCH v2 1/4] nmi_backtrace: add more trigger_*_cpu_backtrace()
 methods
In-Reply-To: <56EB32A6.5090203@mellanox.com>
References: <1458147733-29338-1-git-send-email-cmetcalf@mellanox.com>
 <1458147733-29338-2-git-send-email-cmetcalf@mellanox.com>
 <20160317193600.GY6344@twins.programming.kicks-ass.net>
 <56EB3050.3060607@mellanox.com>
 <20160317223821.GZ6344@twins.programming.kicks-ass.net>
 <56EB32A6.5090203@mellanox.com>
Message-ID: <20160317231427.GC6344@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 17, 2016 at 06:41:42PM -0400, Chris Metcalf wrote:
> The build bot caught the fact that I missed arch/xtensa since it doesn't use
> LOCK_TEXT, so if you're testing on that (ok maybe unlikely) you can add this:

Ha!, no. regular boring x86_64.
