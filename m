From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Tue, 19 Oct 2010 17:17:40 +0200
Subject: [PATCH] sdhci-esdhc-imx: fix timeout on i.MX's sdhci
In-Reply-To: <20101019150743.GA26784@pengutronix.de>
References: <1287492541-3060-1-git-send-email-eric@eukrea.com>
	<20101019150743.GA26784@pengutronix.de>
Message-ID: <4CBDB694.4000209@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

Le 19/10/2010 17:07, Wolfram Sang a ?crit :
> On Tue, Oct 19, 2010 at 02:49:01PM +0200, Eric B?nard wrote:
>> this patch fix timeout problems on i.MX51 as suggested by
>> Richard Zhu.
>> more tests are needed to check if this quirk can be removed
>> for i.MX25 and 35.
>
> Didn't you have such boards?

I do have, but I can't do the tests until next week because of other priorities.

Eric
