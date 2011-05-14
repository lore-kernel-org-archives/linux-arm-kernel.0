From: tom.leiming@gmail.com (Ming Lei)
Date: Sat, 14 May 2011 16:48:52 +0800
Subject: [patch v4 3/3] arm: omap4: support pmu
In-Reply-To: <BANLkTi=u8Lv=MR+gW_KmsOJn99Vv2sNkmg@mail.gmail.com>
References: <1299598729-27974-1-git-send-email-tom.leiming@gmail.com>
	<1299598729-27974-4-git-send-email-tom.leiming@gmail.com>
	<BANLkTi=u8Lv=MR+gW_KmsOJn99Vv2sNkmg@mail.gmail.com>
Message-ID: <BANLkTimkrf8-+-JTQy-gWK9t9grj-n0Ftw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rabin,

2011/5/14 Rabin Vincent <rabin@rab.in>:
> What happened to this patch? ?It is neither in mainline nor in
> linux-next.
>

This patch depends on the two with titles:

      introduce cross trigger interface helpers
      pmu: allow platform specific irq enable/disable handling

and the above patches have been submitted to RMK's patch system
as 6839/1 and 6840/1, but not been pushed to -next or mainline by rmk,
so I can't ask omap guys to merge this one into their tree now.


thanks,
-- 
Ming Lei
