From: joe@perches.com (Joe Perches)
Date: Wed, 04 Jul 2012 20:25:50 -0700
Subject: [PATCH 4 2/4] NET ethernet introduce mac_platform helper
In-Reply-To: <4FF507FF.3000604@linaro.org>
References: <20120705024259.26317.16000.stgit@build.warmcat.com>
 <20120705024446.26317.49693.stgit@build.warmcat.com>
 <1341457963.2058.13.camel@joe2Laptop> <4FF507FF.3000604@linaro.org>
Message-ID: <1341458750.2058.15.camel@joe2Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-07-05 at 11:20 +0800, Andy Green wrote:
> On 05/07/12 11:12, the mail apparently from Joe Perches included:
[]
> >> diff --git a/net/ethernet/mac-platform.c b/net/ethernet/mac-platform.c
> > []
> >> +static int mac_platform_netdev_event(struct notifier_block *this,
> >> +						unsigned long event, void *ptr)
> >
> > alignment to parenthesis please.
> 
> OK.  Although different places in the kernel seem to have different 
> expectations about that.

net and drivers/net is pretty consistent.
Most of the exceptions are old code.
Some of those exceptions are being slowly updated too.

cheers, Joe
