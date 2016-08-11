From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 11 Aug 2016 18:15:50 +0800
Subject: [PATCH v10 0/8] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
In-Reply-To: <0befd611-91a7-88e9-1686-82929c1745e8@semihalf.com>
References: <1469535565-20924-1-git-send-email-fu.wei@linaro.org>
 <0befd611-91a7-88e9-1686-82929c1745e8@semihalf.com>
Message-ID: <510fa357-a729-4ce1-7c10-4cef06feb7b7@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 2016/8/11 17:37, Tomasz Nowicki wrote:
> Hi Fu,
>
> Do you mind if I send IORT series where new drivers/acpi/arm64 directory
> would be introduced in first place ? This means your GTDT set would
> depend on IORT.

I think it's reasonable as the IORT for ITS is the key device enablement
for PCI MSI. I talked to Fuwei offline and he is fine with it.

But both the GTDT patchset and IORT are in good shape now, can we
targeting both of them for 4.9 kernel (since all go via tip tree)?

Thanks
Hanjun
