From: b32955@freescale.com (Huang Shijie)
Date: Wed, 10 Oct 2012 13:01:24 +0800
Subject: [PATCH] ARM: dts: imx28: add the `clock-names` for gpmi-nand
In-Reply-To: <CAOMZO5A0UX6y3MtHdzZ8V2Z52qsH8Yy-BVtOYEN_OpBezEsvQw@mail.gmail.com>
References: <1349837086-21844-1-git-send-email-b32955@freescale.com>
 <CAOMZO5A0UX6y3MtHdzZ8V2Z52qsH8Yy-BVtOYEN_OpBezEsvQw@mail.gmail.com>
Message-ID: <50750124.5060208@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?10?10? 12:54, Fabio Estevam ??:
> Hi Huang,
>
> On Tue, Oct 9, 2012 at 11:44 PM, Huang Shijie<b32955@freescale.com>  wrote:
>> The current DT node misses the `clocks-names` item for gpmi-nand.
>> So the gpmi-nand driver could not find the proper clock.
>>
>> This patch fixes this issue.
>>
>> Signed-off-by: Huang Shijie<b32955@freescale.com>
> Thanks for the fix.
>
> Could you please also fix mx23 in the same patch?
I am just fixing it now. :)

Huang Shijie
> Regards,
>
> Fabio Estevam
>
