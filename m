From: gerg@snapgear.com (Greg Ungerer)
Date: Sat, 8 Sep 2012 00:11:55 +1000
Subject: [PATCH] ARM: ks8695: add board support for the OpenGear boards
 based on the KS8695
In-Reply-To: <201209071221.56938.arnd@arndb.de>
References: <1346996139-5692-1-git-send-email-gerg@snapgear.com>
 <201209071221.56938.arnd@arndb.de>
Message-ID: <504A00AB.3050702@snapgear.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 09/07/2012 10:21 PM, Arnd Bergmann wrote:
> On Friday 07 September 2012, gerg at snapgear.com wrote:
>> From: Greg Ungerer <gerg@uclinux.org>
>>
>> A number of boards produced by OpenGear and based on the Micrel KS8695 SoC.
>> Add board support to the KS8695 kernel code to support them.
>>
>> The following machine type entries will need to be added back into the
>> mach-types file with these in mainline:
>>
>>      cm4008      MACH_CM4008       CM4008       624
>>      cm41xx      MACH_CM41XX       CM41XX       672
>>      cm4002      MACH_CM4002       CM4002       876
>>      im42xx      MACH_IM42XX       IM42XX       1105
>>      im4004      MACH_IM4004       IM4004       1400
>>
>> Signed-off-by: Greg Ungerer <gerg@uclinux.org>
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
>
> Hi Greg,
>
> Both ks8695 patches look good to me, I think we can apply them to the
> arm-soc tree right away. If you agree, I'd also like to apply the
> patch below to list you as a contact for the platform. If you prefer,
> we can also list it as Maintained.

Patch looks good. I am fine with marking it is maintained as well.


> 	Arnd
>
> 8<----
> ARM: ks8695: add maintainers entry
>
> Greg Ungerer has hardware for this platform and is testing it
> regularly.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Greg Ungerer <gerg@uclinux.org>


> diff --git a/MAINTAINERS b/MAINTAINERS
> index fdc0119..f7b8d14 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -913,6 +913,12 @@ W:	http://www.digriz.org.uk/ts78xx/kernel
>   S:	Maintained
>   F:	arch/arm/mach-orion5x/ts78xx-*
>
> +ARM/MICREL KS8695 ARCHITECTURE
> +M:	Greg Ungerer <gerg@uclinux.org>
> +L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> +F:	arch/arm/mach-ks8695
> +S:	Odd Fixes
> +
>   ARM/MIOA701 MACHINE SUPPORT
>   M:	Robert Jarzmik <robert.jarzmik@free.fr>
>   L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)

Regards
Greg


-- 
------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg at snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close,                            FAX:         +61 7 3891 3630
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
