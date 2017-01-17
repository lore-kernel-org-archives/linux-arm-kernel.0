From: slash.tmp@free.fr (Mason)
Date: Tue, 17 Jan 2017 10:42:06 +0100
Subject: [PATCH] tcb_clksrc: Use 32 bit tcb as sched_clock
In-Reply-To: <20170111135059.21318-1-david.engraf@sysgo.com>
References: <20170111135059.21318-1-david.engraf@sysgo.com>
Message-ID: <5bfff08c-4c51-2c46-a63c-102fbeaf2135@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/01/2017 14:50, David Engraf wrote:

> Subject: [PATCH] tcb_clksrc: Use 32 bit tcb as sched_clock

I was puzzled by the TCB acronym :-)

Trusted Computing Base
Task Control Block
Transfer Control Block
Test Control Board

In fact, it (probably) stands for Timer Counter Block, which makes
sense for a clksrc patch.

Regards.
