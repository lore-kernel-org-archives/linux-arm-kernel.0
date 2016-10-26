From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 26 Oct 2016 15:28:23 +0530
Subject: [PATCH v6 2/5] ARM: davinci: da8xx: Add CFGCHIP syscon platform
 declaration.
In-Reply-To: <1477451211-31979-3-git-send-email-david@lechnology.com>
References: <1477451211-31979-1-git-send-email-david@lechnology.com>
 <1477451211-31979-3-git-send-email-david@lechnology.com>
Message-ID: <20722288-9567-16d7-c591-5872ef8d8b9e@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 October 2016 08:36 AM, David Lechner wrote:
> The CFGCHIP registers are used by a number of devices, so using a syscon
> device to share them. The first consumer of this will by the phy-da8xx-usb

"will be the .." 

Also, in subject line, "platform device" instead of "platform 
declaration". Also lose the period at at the end of subject line

> driver.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Applied to v4.10/soc. Here is the final commit text.

---
ARM: davinci: da8xx: Add CFGCHIP syscon platform device

The CFGCHIP registers are used by a number of devices, so use a syscon
device to share them. The first consumer of this will by the phy-da8xx-usb
driver.

Add the syscon device and register it.

Signed-off-by: David Lechner <david@lechnology.com>
[nsekhar at ti.com: minor commit message fixes]
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---

Thanks,
Sekhar
