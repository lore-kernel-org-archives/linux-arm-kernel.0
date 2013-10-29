From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 30 Oct 2013 00:40:39 +0300
Subject: [PATCH] sh-pfc: r8a7791 PFC support V2
In-Reply-To: <52702A14.7020005@cogentembedded.com>
References: <20131016214605.3868.54890.sendpatchset@w520>
 <1428789.AD4dgYWceb@avalon> <52702A14.7020005@cogentembedded.com>
Message-ID: <52702B57.50701@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/30/2013 12:35 AM, Sergei Shtylyov wrote:

>>> From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>

>>> Add PFC support for the r8a7791 SoC V2 including pin groups for
>>> on-chip devices such as MSIOF, SCIF, USB, MMC, SDHI, DU.

>>> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
>>> Signed-off-by: Kunihito Higashiyama <kunihito.higashiyama.ur@renesas.com>
>>> Signed-off-by: Yoshikazu Fujikawa <yoshikazu.fujikawa.ue@renesas.com>
>>> Signed-off-by: Nobuyuki HIRAI <nobuyuki.hirai.xe@renesas.com>
>>> Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
>>> Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
>>> Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
>>> [damm at opensource.se: Forward ported to upstream, minor fixes]
>>> Signed-off-by: Magnus Damm <damm@opensource.se>
> [...]

>>> --- /dev/null
>>> +++ work/drivers/pinctrl/sh-pfc/pfc-r8a7791.c    2013-10-17
>> 06:35:00.000000000

> [...]

>> I'm still a bit unsure about the DU pin groups. Would it be possible to get
>> access to the SoC datasheet ?

>> In the worst case I can take the patch as-is and fix any issue later, as the
>> DU driver doesn't support the r8a7791 yet anyway. So,

>> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>> I've taken the patch to my tree and will push it as-is, or with modifications
>> to the DU pin groups as needed if I can get access to the documentation before
>> the next merge window.

>     Looks like it got stuck in your tree? I have my Ether work run-time
> dependent on this patch...

    Ah, seeing your pull request now but it looks like Linus hasn't pulled yet...

WBR, Sergei
