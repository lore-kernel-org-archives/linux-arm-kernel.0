From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Fri, 15 Oct 2010 10:19:58 +0200
Subject: [PATCH 2/5] mx25: add defconfig
In-Reply-To: <20101015072254.GG6747@pengutronix.de>
References: <1287097205-18595-1-git-send-email-eric@eukrea.com>
	<1287097205-18595-2-git-send-email-eric@eukrea.com>
	<20101015072254.GG6747@pengutronix.de>
Message-ID: <4CB80EAE.9060103@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Le 15/10/2010 09:22, Uwe Kleine-K?nig a ?crit :
> On Fri, Oct 15, 2010 at 01:00:02AM +0200, Eric B?nard wrote:
>> Signed-off-by: Eric B?nard<eric@eukrea.com>
> I'd like to see mx25 in a defconfig, too.  In case RMK subjects
> that adding a defconfig isn't sensible, I think the best bet we have is
> merging mx3 and mx25 into mach-imx and working to allow compiling a
> kernel that supports these two in a single kernel.  (mx3 and mx25 share
> PHYS_OFFSET, so this is easier than the other merges.)
>
I think we can go with this defconfig for the short time and have more time to 
merge imx/mx25 and mx3.

Eric
