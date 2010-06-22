From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Tue, 22 Jun 2010 19:21:56 +0200
Subject: [PATCH 09/16] arm/mx2/mbimx27: compile fixes
	with	CONFIG_TOUCHSCREEN_ADS7846=y
In-Reply-To: <20100622161314.GA18606@pengutronix.de>
References: <20100524195430.GA28403@pengutronix.de>	<1274730951-29106-9-git-send-email-u.kleine-koenig@pengutronix.de>	<4BFADD4F.80309@eukrea.com>
	<20100524203428.GB29092@pengutronix.de>
	<20100622161314.GA18606@pengutronix.de>
Message-ID: <4C20F134.2070801@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Le 22/06/2010 18:13, Uwe Kleine-K?nig a ?crit :
> On Mon, May 24, 2010 at 10:34:28PM +0200, Uwe Kleine-K?nig wrote:
>> What do you think about adding TOUCHSCREEN_ADS7846=m to mx27_defconfig?
>>
>> Other than that I'm OK with your patch, too.  I will remove this patch
>> from my queue.
> If we want to have ADS7846 at least compilable in .35 we should go with
> my patch as your's is (IMHO) too intrusive after -rc1.
>
unless this has changed recently, this board is not in mx27_defconfig 
for 2.6.35-rc nor in Sasha's tree so adding  TOUCHSCREEN_ADS7846=m to 
defconfig shouldn't break anything.

Eric
