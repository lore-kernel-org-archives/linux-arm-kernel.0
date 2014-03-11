From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Tue, 11 Mar 2014 11:29:13 -0700
Subject: [PATCH v2 0/7] tty: xuartps: Rebranding + DT documentation
In-Reply-To: <531EE993.80400@monstr.eu>
References: <1394487610-2419-1-git-send-email-soren.brinkmann@xilinx.com>
 <531EE993.80400@monstr.eu>
Message-ID: <b4e6dfe6-ad49-4d81-855b-8dd905665616@VA3EHSMHS039.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-03-11 at 11:46AM +0100, Michal Simek wrote:
> On 03/10/2014 10:40 PM, Soren Brinkmann wrote:
> > Hi,
> > 
> > this series rebrands the Xilinx PS UART driver as Cadence UART and
> > documents its DT bindings (+ some clean up along the way).
> > 
> > The rebranding goes as far as reasonable. Things like file name, kconfig
> > symbols and other things with user space impact are left as is. Please
> > refer to the discussion in the RFC threads[1-2] for more details.
> > 
> > Similar the DT binding has been extended. In addition to the new and
> > preferred Cadence binding, the current xuartps binding is maintained.
> > Though, only the Cadence names for clock-names are documented.
> > 
> > References:
> >  [1]  https://lkml.org/lkml/2014/3/4/405
> >  [2]  https://lkml.org/lkml/2014/3/7/450
> > 
> > v2:
> >  - no changes regarding the patches
> >  - fixed (I sincerely hope) email recipients
> > 
> > Changes from the latest RFC:
> >  - squashed function/symbol renaming into 'tty: xuartps: Rebrand driver
> >    as Cadence UART'
> >  - Revised the commit message of 'tty: xuartps: Don't write IRQ disable
> >    register to enable interrupts' (was 'tty: xuartps: Remove bogus
> >    comment and register write'
> 
> One more thing. I was thinking this is based on my 3 patches I have
> already sent to mainline. But as I see they are not applied yet.
> 
> https://lkml.org/lkml/2014/1/21/107

I think my cleanup patch covers these changes as well. I'll see if it
makes sense to separate out this patch.

> https://lkml.org/lkml/2014/1/21/101

This is obsolete with the rebranding, IMHO.

> http://www.spinics.net/lists/arm-kernel/msg302796.html

I can add this to this series.

	S?ren
