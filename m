From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 22 Oct 2013 11:13:46 -0600
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <20131022150426.GF29341@beef>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131020220839.GT2443@sirena.org.uk>
 <5264576F.6050307@wwwdotorg.org>
 <alpine.LFD.2.03.1310201911190.1951@syhkavp.arg>
 <52658EBC.8020800@wwwdotorg.org>
 <alpine.LFD.2.03.1310211632460.1951@syhkavp.arg>
 <20131022093923.GC15640@ulmo.nvidia.com>
 <20131022150426.GF29341@beef>
Message-ID: <20131022171346.GE4061@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 22, 2013 at 11:04:26AM -0400, Matt Porter wrote:

> DT has many benefits. It would be great to leverage them as long as it
> doesn't interfere with the rate of change and willingness to evolve code
> that's always been the strength of the kernel process. That strength is
> too valuable to trade away for the "DT as ABI" vision.

I agree with this, and have posted similar things before.

The question I asked last time this came up, which was left unaswered:

 Who does this stable DT ABI vision benifit, and how much is that
 benifit worth?

As an embedded ODM, I don't get very much value out of it, and I think
others in my space would say the same.

I continue to think the embedded vs not embedded are different and it
makes no sense to pretend that my embedded system has the same
requirements as something like a chromebook.

Jason
