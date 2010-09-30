From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 30 Sep 2010 11:38:33 +0900
Subject: Please don't edit the subject. Use S5PC110 & S5PC210 as is
In-Reply-To: <AANLkTi=NFz95jvk73cgXGV-kzj7FFazgMJ6D+GOXr3Kb@mail.gmail.com>
References: <AANLkTi=NFz95jvk73cgXGV-kzj7FFazgMJ6D+GOXr3Kb@mail.gmail.com>
Message-ID: <006201cb6048$962b6810$c2823830$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> Hi,
> 
> Please don't edit the subject.
> 
> http://git.kernel.org/?p=linux/kernel/git/kgene/linux-
> samsung.git;a=commitdiff;h=d8c3d96f5df54251c06686bb00811e4b7e0f6547
> http://git.kernel.org/?p=linux/kernel/git/kgene/linux-
> samsung.git;a=commitdiff;h=7dcde8f18b0df4d332d6b359fd6270772a42f71f
> 
> Patches from DMC we decide to use the S5PC110 & S5PC210 as we're only
> received the Spec C110 & C210.
> Most of people including mobile division don't know the V210 & V310
> SOC receptively.
> 
> We're already confusing with names, we always talk with C110 & C210
> but works on V210 & V310 directory.
> 
> well question. What's the SOC is used at Galaxy S & wave phone?
> 
> I think S5PC110 is more well known than S5PV210.
> 
> http://lwn.net/Articles/399720/
> The conclusion of the 2.6.36 merge window
> Systems and processors: Income s.r.o. PXA270 single-board computers,
> Wiliboard WBD-111 boards, and Samsung S5PC210-based systems.
> 
> Thank you,
> Kyungmin Park

As I'm a maintainer of Samsung S5P SoCs, I would like to use second column
in the subject line to indicate the ARCH_XXX name like following.
'ARM: S5PV210: <patch subject>'
As you know, it means the patch is mainly regarding ARCH_S5PV210
(arch/arm/mach-s5pv210/).

It can be help to many people, including me that the title speak where it
belong to.

And I believe someone who can use git log to see the log and source, S5PC110
is in the 'arch/arm/mach-s5pv210/'.

If you want to display S5PC110 or S5PC210 in the subject, you can properly
add it in the last column of the title.

And Hmm...
I wonder why posted this to LKML

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
