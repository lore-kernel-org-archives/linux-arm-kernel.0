From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 22 Oct 2013 10:49:08 -0700
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <20131022171346.GE4061@obsidianresearch.com>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131020220839.GT2443@sirena.org.uk>
 <5264576F.6050307@wwwdotorg.org>
 <alpine.LFD.2.03.1310201911190.1951@syhkavp.arg>
 <52658EBC.8020800@wwwdotorg.org>
 <alpine.LFD.2.03.1310211632460.1951@syhkavp.arg>
 <20131022093923.GC15640@ulmo.nvidia.com>
 <20131022150426.GF29341@beef>
 <20131022171346.GE4061@obsidianresearch.com>
Message-ID: <20131022174908.GA11614@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 22, 2013 at 11:13:46AM -0600, Jason Gunthorpe wrote:
> On Tue, Oct 22, 2013 at 11:04:26AM -0400, Matt Porter wrote:
> 
> > DT has many benefits. It would be great to leverage them as long as it
> > doesn't interfere with the rate of change and willingness to evolve code
> > that's always been the strength of the kernel process. That strength is
> > too valuable to trade away for the "DT as ABI" vision.
> 
> I agree with this, and have posted similar things before.
> 
> The question I asked last time this came up, which was left unaswered:
> 
>  Who does this stable DT ABI vision benifit, and how much is that
>  benifit worth?
> 

You might add: Who does the DT restriction to "hardware description only"
(ie it must not describe what the system is supposed to do with the hardware)
benefit, and how much is that benefit (or restriction) worth ?

Guenter
