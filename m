From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 16 Feb 2012 14:31:37 +1100
Subject: [PATCH RFC 0/4] Scheduler idle notifiers and users
In-Reply-To: <1329318063.2293.136.camel@twins>
References: <20120208013959.GA24535@panacea>
 <1328670355.2482.68.camel@laptop> <20120208202314.GA28290@redhat.com>
 <1328736834.2903.33.camel@pasglop> <20120209075106.GB18387@elte.hu>
 <4F35DD3E.4020406@codeaurora.org> <20120211144530.GA497@elte.hu>
 <4F3AEC4E.9000303@codeaurora.org> <1329313085.2293.106.camel@twins>
 <20120215140245.GB27825@n2100.arm.linux.org.uk>
 <1329318063.2293.136.camel@twins>
Message-ID: <1329363097.3772.46.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-02-15 at 16:01 +0100, Peter Zijlstra wrote:
> 
> Thing is, the scheduler doesn't care about completion, all it needs is
> to be able to kick-start the thing atomically. So you really have to
> wait for it or can you do an interrupt driven state machine?

Or the scheduler callback could schedule a wq to do the job ?

Cheers,
Ben.
