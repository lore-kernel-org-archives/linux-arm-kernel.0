From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Tue, 18 Apr 2017 21:32:19 +0200
Subject: [PATCH] arm64: dts: allwinner: a64: Add UART2 pin nodes
In-Reply-To: <20170418053458.phcbp4da3vatejpg@lukather>
References: <20170414171320.19743-1-afaerber@suse.de>
 <20170418053458.phcbp4da3vatejpg@lukather>
Message-ID: <81e89b9b-1b1c-42f7-eabc-e262cfd99735@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 18.04.2017 um 07:34 schrieb Maxime Ripard:
> On Fri, Apr 14, 2017 at 07:13:20PM +0200, Andreas F?rber wrote:
>> UART2 is exposed on the Pi connector of Pine64. Make a pinctrl node
>> available at the SoC level, to simplify enabling UART2 via DT overlay.
>>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> 
> Applied, thanks!

Thanks, that was fast.

> Could you also create the node in the pine64 DTS (with an explicit
> status = "disabled" in there) so that the overlay would be even easier
> to make ?

Makes sense. I went ahead and did it for all UART nodes then - careful,
final patch is neither build- nor runtime-tested yet.

Cheers,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
