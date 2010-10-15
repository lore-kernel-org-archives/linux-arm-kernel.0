From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Fri, 15 Oct 2010 11:16:27 +0200
Subject: [PATCH v4] imx-esdhc: update devices registration
In-Reply-To: <20101015090105.GK6747@pengutronix.de>
References: <20101012153155.GE4470@pengutronix.de>
	<1286904825-6432-1-git-send-email-eric@eukrea.com>
	<20101015090105.GK6747@pengutronix.de>
Message-ID: <4CB81BEB.1000909@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Le 15/10/2010 11:01, Uwe Kleine-K?nig a ?crit :
> On Tue, Oct 12, 2010 at 07:33:45PM +0200, Eric B?nard wrote:
>> Tested on i.MX25 and i.MX35 and i.MX51
>>
>> Signed-off-by: Eric B?nard<eric@eukrea.com>
> Looks good now, but the patch doesn't apply for me:
>
yes you need the i.MX51 part before. The process is :
- add MX25 & MX35 SDHC support
- add MX51 SDHC support
- update the way SDHC is registered for MX25, MX35 and MX51.

Eric
