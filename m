From: will.deacon@arm.com (Will Deacon)
Date: Sun, 15 May 2011 15:16:00 +0100
Subject: [patch v4 3/3] arm: omap4: support pmu
In-Reply-To: <BANLkTimkrf8-+-JTQy-gWK9t9grj-n0Ftw@mail.gmail.com>
References: <1299598729-27974-1-git-send-email-tom.leiming@gmail.com>
	<1299598729-27974-4-git-send-email-tom.leiming@gmail.com>
	<BANLkTi=u8Lv=MR+gW_KmsOJn99Vv2sNkmg@mail.gmail.com>
	<BANLkTimkrf8-+-JTQy-gWK9t9grj-n0Ftw@mail.gmail.com>
Message-ID: <1305468960.2848.2.camel@jazzbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Adding Avik],


On Sat, 2011-05-14 at 09:48 +0100, Ming Lei wrote:
> Hi Rabin,
> 
> 2011/5/14 Rabin Vincent <rabin@rab.in>:
> > What happened to this patch?  It is neither in mainline nor in
> > linux-next.
> >
> 
> This patch depends on the two with titles:
> 
>       introduce cross trigger interface helpers
>       pmu: allow platform specific irq enable/disable handling
> 
> and the above patches have been submitted to RMK's patch system
> as 6839/1 and 6840/1, but not been pushed to -next or mainline by rmk,
> so I can't ask omap guys to merge this one into their tree now.

I don't think that Avik's problem with this patch has been fully
addressed yet:

http://lists.infradead.org/pipermail/linux-arm-kernel/2011-April/046899.html

So regardless of the state of -next, I think there's still some more
work to do on this code before it can go upstream.

Will
