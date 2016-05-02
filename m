From: sre@kernel.org (Sebastian Reichel)
Date: Mon, 2 May 2016 22:12:17 +0200
Subject: Nokia N900 retention mode in v4.6, camera buttons fun
In-Reply-To: <20160501154855.GA24970@earth>
References: <20160411094130.GA5753@amd> <20160411211026.GH5995@atomide.com>
 <20160412121658.GA32486@amd> <20160412123013.GA12296@amd>
 <20160412163055.GP5995@atomide.com> <20160417175539.GA502@amd>
 <20160421130450.GQ29406@pali> <20160429200559.GA16598@earth>
 <20160501085236.GA14243@amd> <20160501154855.GA24970@earth>
Message-ID: <20160502201216.GA19211@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

On Sun, May 01, 2016 at 05:48:56PM +0200, Sebastian Reichel wrote:
> > I see latest series, and it also talks about frequency scaling.
> > But I guess it is not going to fix this issue?
> 
> No, this is independent of the runtime PM problems. I also worked
> on runtime PM/idling yesterday and pm_runtime_irq_safe is the main
> culprit for breaking it (not the only one, though). It's not yet
> finished though

I will be on vacation for a week starting tomorrow. If you want to
play around with my intermediate SSI PM status, you can try this branch:

https://git.kernel.org/cgit/linux/kernel/git/sre/linux-hsi.git/log/?h=runtime-pm-fixes

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160502/70e10112/attachment.sig>
