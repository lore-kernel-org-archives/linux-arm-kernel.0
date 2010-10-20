From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Wed, 20 Oct 2010 17:05:55 +0200
Subject: [PATCH v4] imx-esdhc: update devices registration
In-Reply-To: <20101020145532.GD19834@pengutronix.de>
References: <20101012153155.GE4470@pengutronix.de>
	<1286904825-6432-1-git-send-email-eric@eukrea.com>
	<20101020145532.GD19834@pengutronix.de>
Message-ID: <4CBF0553.30000@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Le 20/10/2010 16:55, Uwe Kleine-K?nig a ?crit :
> On Tue, Oct 12, 2010 at 07:33:45PM +0200, Eric B?nard wrote:
>> Tested on i.MX25 and i.MX35 and i.MX51
>>
>> Signed-off-by: Eric B?nard<eric@eukrea.com>
> This patch (or more exact: the version of this patch that Sascha picked
> up) breaks compiling mx3_defconfig.
>
I may have made a mistake somewhere using git when providing the branch for 
Sascha to merge it because I upgraded this patch when I tested mx3_defconfig 
to have it compile !

> The better fix would be to delete mxcsdhc_device[01] from
> arch/arm/mach-mx3/devices.c and convert all users to the new function.
> Volunteers?  Eric?
>
I will see what I can do next week.

Eric
