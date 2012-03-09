From: javier.martin@vista-silicon.com (javier Martin)
Date: Fri, 9 Mar 2012 09:00:35 +0100
Subject: [PATCH v2 00/13] dmaengine: imx-dma: merge dma arch code into
 dmaengine.
In-Reply-To: <20120308200448.GR3852@pengutronix.de>
References: <1331130825-14947-1-git-send-email-javier.martin@vista-silicon.com>
 <20120308200448.GR3852@pengutronix.de>
Message-ID: <CACKLOr2_y9aw+-79d4FfKsOuiDdOvDHAanQ6j+qF4Ynf2r5rag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On 8 March 2012 21:04, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Wed, Mar 07, 2012 at 03:33:32PM +0100, Javier Martin wrote:
>> The following series have to be applied on top of the following patches:
>> [PATCH v2 1/2] dmaengine: Add support for MEMCPY for imx-dma.
>> [PATCH v3 2/2] dmaengine: Add support for multiple descriptors for imx-dma.
>>
>> As discussed with Vinod and Sascha, the file 'arch/arm/mach-imx/dma-v1.c'
>> is deprecated and no new patches are accepted for it.
>>
>> This series merges this code into the imx-dma.c dmaengine driver.
>>
>
> I can't find a branch to apply this on. Could you provide a git tree?

I'm developing and testing here:

git://git.infradead.org/users/vkoul/slave-dma.git next

> If you have to repost this series please consider using -M with git
> format-patch.

OK, thanks for the suggestion.

Regards.
-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
