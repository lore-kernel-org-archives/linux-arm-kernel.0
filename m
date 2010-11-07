From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Sun, 7 Nov 2010 10:29:05 -0600
Subject: [PATCH 6/6] omap: iommu: code reorganization and cleanup
In-Reply-To: <AANLkTikhTmmy0fcOMfA0tUE=wuj03X1KajmB4A-ygxPz@mail.gmail.com>
References: <1289006396-27230-1-git-send-email-omar.ramirez@ti.com>
	<1289006396-27230-7-git-send-email-omar.ramirez@ti.com>
	<AANLkTikhTmmy0fcOMfA0tUE=wuj03X1KajmB4A-ygxPz@mail.gmail.com>
Message-ID: <AANLkTi=oWi7Dgh8L-hFfJ8B4rEiD+xUbtgX21+-q63d-@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 6, 2010 at 3:34 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sat, Nov 6, 2010 at 3:19 AM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
>> Since omap-iommu is now using hwmod, there are structures and
>> arrays that can be cleaned up to increase the readability of
>> the code.
>>
>> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>
> NAK.

Mostly agree, no need to discuss as this is going to change, will keep
CONFIG_MPU_BRIDGE_IOMMU.

Regards,

Omar
