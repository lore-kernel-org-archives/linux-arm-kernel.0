From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 27 Aug 2009 10:31:42 +0800 (CST)
Subject: [PATCH 4/5] PalmGSM: generalisation of Treo680 code to PalmGSM
In-Reply-To: <1251333811-22360-5-git-send-email-sleep_walker@suse.cz>
References: <1251333811-22360-1-git-send-email-sleep_walker@suse.cz>
	<1251333811-22360-2-git-send-email-sleep_walker@suse.cz>
	<1251333811-22360-3-git-send-email-sleep_walker@suse.cz>
	<1251333811-22360-4-git-send-email-sleep_walker@suse.cz>
	<1251333811-22360-5-git-send-email-sleep_walker@suse.cz>
Message-ID: <alpine.DEB.2.00.0908271025300.27084@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thu, 27 Aug 2009, Tom?? ?ech wrote:

> From: Tom?? ?ech <sleep walker@suse.cz>
>
> ---
> arch/arm/mach-pxa/Kconfig                |    5 +
> arch/arm/mach-pxa/Makefile               |    2 +-
> arch/arm/mach-pxa/include/mach/palmgsm.h |   60 ++++
> arch/arm/mach-pxa/include/mach/treo680.h |   49 ---
> arch/arm/mach-pxa/palmgsm.c              |  559 ++++++++++++++++++++++++++++++
> arch/arm/mach-pxa/treo680.c              |  528 ----------------------------

I don't actually care too much about the naming - as long as 685 can stay 
within treo680.c, I don't see any problem with that. The real question is:
is palmgsm.c the proper name for all these devices?

And you may want to try the switch '-M' in 'git format-patch' or 'git 
diff'.
