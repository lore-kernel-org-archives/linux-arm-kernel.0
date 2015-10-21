From: linux.amoon@gmail.com (Anand Moon)
Date: Wed, 21 Oct 2015 17:25:51 +0530
Subject: [PATCH v2 3/6] arm: dts: Add syscon-{reboot,
 poweroff} nodes for exynos5
In-Reply-To: <562617A9.3020302@osg.samsung.com>
References: <1445333085-22837-1-git-send-email-alim.akhtar@samsung.com>
 <1445333085-22837-4-git-send-email-alim.akhtar@samsung.com>
 <562617A9.3020302@osg.samsung.com>
Message-ID: <CANAwSgRFJWvFBK0QnkH3ohRkW1cL97a11Ss3WnOpUPUHyNhkmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Alim,

On 20 October 2015 at 16:00, Javier Martinez Canillas
<javier@osg.samsung.com> wrote:
> Hello Alim,
>
> On 10/20/2015 11:24 AM, Alim Akhtar wrote:
>> This patch adds syscon-{reboot, poweroff} nodes to allow the
>> generic syscon-{reboot, poweroff} driver to reset/poweroff exynos5 SoCs.
>>
>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>> Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
>> Acked-by: Moritz Fischer <moritz.fischer@ettus.com>
>> ---
>>  arch/arm/boot/dts/exynos5.dtsi |   14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>
> Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>
>
> Best regards,
> --
> Javier Martinez Canillas
> Open Source Group
> Samsung Research America
> --

Tested on OdroidXU3.

Tested-by: Anand Moon <linux.amoon@gmail.com>

-Anand Moon

> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
