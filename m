From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Tue, 9 Aug 2016 23:46:44 +0200
Subject: [PATCH 0/3] ARM: dts: pinctrl-imx: some cleanups and fixes
In-Reply-To: <20160809030927.GJ4678@tiger>
References: <1467749993-14533-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20160809030927.GJ4678@tiger>
Message-ID: <1be29ac5-8be8-35aa-d3ca-2b5795be2e0e@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 09.08.2016 um 05:09 schrieb Shawn Guo:
> On Tue, Jul 05, 2016 at 10:19:50PM +0200, Uwe Kleine-K?nig wrote:
>> Hello,
>>
>> when I asked Andreas F?rber to drop the function device nodes in his
>> patch that added support for the Udoo Neo boards, he rightfully said:
>> "OK, will do. Adopted from imx6sx-sdb.dtsi and imx6sx-sabreauto.dts -
>> please update the existing files to be like you expect new ones to be.".
>> This is done in patch 1. While the short stat for this patch is
>>
>> 	87 files changed, 7717 insertions(+), 7899 deletions(-)
> 
> I do not feel this is really necessary.  People should always refer to
> the latest dts addition as example.

The problem is that it's not obvious what "the latest dts addition" is.
When I add an i.MX6 SoloX I compared other sx files but not all imx or
random other .dts files.

Sorry for not testing this earlier, Uwe, I did receive the full patch.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
