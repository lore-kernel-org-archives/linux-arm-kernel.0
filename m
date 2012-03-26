From: javier.martin@vista-silicon.com (javier Martin)
Date: Mon, 26 Mar 2012 14:56:19 +0200
Subject: [PATCH 3/3] i.MX27: visstrim_m10: Remove use of MX2_CAMERA_SWAP16.
In-Reply-To: <20120326121023.GD18420@sapphire.tkos.co.il>
References: <1332760804-22743-1-git-send-email-javier.martin@vista-silicon.com>
 <1332760804-22743-4-git-send-email-javier.martin@vista-silicon.com>
 <20120326121023.GD18420@sapphire.tkos.co.il>
Message-ID: <CACKLOr0abquyZ2bZMnq8pXTL8BXqzN_izK92hdA=gPJ6dBsTdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 March 2012 14:10, Baruch Siach <baruch@tkos.co.il> wrote:
> Hi Javier,
>
> On Mon, Mar 26, 2012 at 01:20:04PM +0200, Javier Martin wrote:
>>
>> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
>> ---
>> ?arch/arm/mach-imx/mach-imx27_visstrim_m10.c | ? ?2 +-
>> ?1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
>> index 3128cfe..4db00c6 100644
>> --- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
>> +++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
>> @@ -164,7 +164,7 @@ static struct platform_device visstrim_tvp5150 = {
>>
>>
>> ?static struct mx2_camera_platform_data visstrim_camera = {
>> - ? ? .flags = MX2_CAMERA_CCIR | MX2_CAMERA_CCIR_INTERLACE | MX2_CAMERA_SWAP16 | MX2_CAMERA_PCLK_SAMPLE_RISING,
>> + ? ? .flags = MX2_CAMERA_CCIR | MX2_CAMERA_CCIR_INTERLACE | MX2_CAMERA_PCLK_SAMPLE_RISING,
>> ? ? ? .clk = 100000,
>> ?};
>
> The order of the last two patches in this series should be switched to
> preserve bisectability.
>
> baruch

You are right.
Thanks.

-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
