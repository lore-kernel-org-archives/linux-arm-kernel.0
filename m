From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 19 Oct 2010 21:36:38 +0200
Subject: [PATCH] sdhci-esdhc-imx: fix timeout on i.MX's sdhci
In-Reply-To: <4CBDB694.4000209@eukrea.com>
References: <1287492541-3060-1-git-send-email-eric@eukrea.com>
	<20101019150743.GA26784@pengutronix.de>
	<4CBDB694.4000209@eukrea.com>
Message-ID: <20101019193638.GB31336@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 19, 2010 at 05:17:40PM +0200, Eric B?nard wrote:
> Hi Wolfram,
>
> Le 19/10/2010 17:07, Wolfram Sang a ?crit :
>> On Tue, Oct 19, 2010 at 02:49:01PM +0200, Eric B?nard wrote:
>>> this patch fix timeout problems on i.MX51 as suggested by
>>> Richard Zhu.
>>> more tests are needed to check if this quirk can be removed
>>> for i.MX25 and 35.
>>
>> Didn't you have such boards?
>
> I do have, but I can't do the tests until next week because of other priorities.

I'd suggest to add a proper patch next week then (maybe together with correct
usage of the MULTIBLOCK-quirk, too?). It's a new driver, so adding update
patches late in the cycle should not cause problems? Of course, Chris makes the
final decision about that.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101019/d51cbf10/attachment.sig>
