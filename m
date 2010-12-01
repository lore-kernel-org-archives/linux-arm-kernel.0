From: vm.rod25@gmail.com (Victor Rodriguez)
Date: Wed, 1 Dec 2010 10:41:48 -0600
Subject: [PATCH v8 4/9] davinci: McASP configuration for Omapl138-Hawkboard
In-Reply-To: <4CF67896.1060002@mvista.com>
References: <1289601535-6746-1-git-send-email-vm.rod25@gmail.com>
	<1289601535-6746-5-git-send-email-vm.rod25@gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930247AFD99E@dbde02.ent.ti.com>
	<4CF67896.1060002@mvista.com>
Message-ID: <AANLkTinj=VAQuqZDzfbP33rzbmJY5iVC2vCyig2f+R-Y@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 1, 2010 at 10:32 AM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> Hello.
>
> Nori, Sekhar wrote:
>
>> On Sat, Nov 13, 2010 at 04:08:50, vm.rod25 at gmail.com wrote:
>>>
>>> From: Victor Rodriguez <victor.rodriguez@sasken.com>
>
>>> This patch defines Pin Mux configuration for MacASP
>>> used on the Hawkboard-L138 system in order to add Audio support
>
>>> Signed-off-by: Victor Rodriguez <victor.rodriguez@sasken.com>
>>> Tested-by: Rene Gonzalez <renegs.2378@gmail.com>
>>> ---
>>> ?arch/arm/mach-davinci/da850.c | ? ?2 +-
>>> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
>>> diff --git a/arch/arm/mach-davinci/da850.c
>>> b/arch/arm/mach-davinci/da850.c
>>> index 63916b9..f033a0a 100644
>>> --- a/arch/arm/mach-davinci/da850.c
>>> +++ b/arch/arm/mach-davinci/da850.c
>>> @@ -591,7 +591,7 @@ const short da850_cpgmac_pins[] __initdata = {
>>> ?const short da850_mcasp_pins[] __initdata = {
>>> ? ? ?DA850_AHCLKX, DA850_ACLKX, DA850_AFSX,
>>> ? ? ?DA850_AHCLKR, DA850_ACLKR, DA850_AFSR, DA850_AMUTE,
>>> - ? ? DA850_AXR_11, DA850_AXR_12,
>>> + ? ? DA850_AXR_11, DA850_AXR_12, DA850_AXR_13, DA850_AXR_14,
>
>> To speed up acceptance of this series, can you please drop this
>> patch and submit the rest of the patches as a reduced series?
>
> ? BTW, I've seen more AXR pins in DA850, so this patch is far from being
> complete anyway.

Ok Sergei we will need to work hard on it

By the way is there any other comment to my patches with out this from
audio and McASP pins ?

Regards

Victor Rodriguez


>> Thanks,
>> Sekhar
>
> WBR, Sergei
>
