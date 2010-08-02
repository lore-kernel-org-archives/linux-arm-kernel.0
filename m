From: vitalywool@gmail.com (Vitaly Wool)
Date: Mon, 2 Aug 2010 18:19:04 +0200
Subject: [PATCH v2 00/20] native support for wl1271 on ZOOM
In-Reply-To: <AANLkTimaSeLqowRHSCivGXTiSE7NatNTR=jLWQYsSo-6@mail.gmail.com>
References: <1279733634-21974-1-git-send-email-ohad@wizery.com>
	<20100726193028.GG3903@tuxdriver.com>
	<1280736987.17809.18.camel@chilepepper>
	<20100802114256.GE12293@atomide.com>
	<AANLkTikvtMbqUdwHtCtdL2xXbQh64pxjApo6ZH6hAXnP@mail.gmail.com>
	<AANLkTimaSeLqowRHSCivGXTiSE7NatNTR=jLWQYsSo-6@mail.gmail.com>
Message-ID: <AANLkTikPSp0_S8kSFmeZJ0qLR3DHKBN=iW_As5891a6v@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ohad,

On Mon, Aug 2, 2010 at 5:59 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>
> Check out patch no. 9:

sorry for the confusion. However, I guess if the platform doesn't
supply this value, we'll just consider it 0? Without any warning,
right?

The problem is, we can't really distinguish between this field not set
and value zero, and that means something is wrong with the design. The
easiest way is probably changing the clock ids to start with 1.

Thanks,
   Vitaly
