From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Wed, 27 Dec 2017 11:33:04 -0800
Subject: [PATCH 2/2] ARM: dts: imx6: RDU2: correct RTC compatible
In-Reply-To: <CAOMZO5BO=kX6ZDLV75c44VPNOggLzf630SHcyzfAU_+4ME2vDQ@mail.gmail.com>
References: <20171227035656.4941-1-andrew.smirnov@gmail.com>
 <20171227035656.4941-2-andrew.smirnov@gmail.com>
 <CAOMZO5BO=kX6ZDLV75c44VPNOggLzf630SHcyzfAU_+4ME2vDQ@mail.gmail.com>
Message-ID: <CAHQ1cqGsLxCTk_dA_rywvF+i1UuYiYdTLEqmsKAo1zO94gWSyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 27, 2017 at 3:11 AM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Andrey,
>
> On Wed, Dec 27, 2017 at 1:56 AM, Andrey Smirnov
> <andrew.smirnov@gmail.com> wrote:
>> The RTC is manufactured by Maxim. This is a cosmetic fix, as Linux
>> doesn't match the vendor string for i2c devices.
>>
>> Cc: Sascha Hauer <kernel@pengutronix.de>
>> Cc: Fabio Estevam <fabio.estevam@nxp.com>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: devicetree at vger.kernel.org
>> Cc: linux-kernel at vger.kernel.org
>> Cc: cphealy at gmail.com
>> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>
> This patch seems to be from Lucas:
> https://patchwork.kernel.org/patch/10099397/
>
> ,so his name should appear in the From field.
>
> Anyway, this patch has been sent earlier and we suggested to keep the
> existing binding, which is the documented form:
> https://patchwork.kernel.org/patch/10099397/


Yes, the patch is from Lucas and I was just being a messenger. And
understood and thanks for the info.

Sorry for the noise and disregard this patch.

Thanks,
Andrey Smirnov
