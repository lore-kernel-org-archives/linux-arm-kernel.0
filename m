From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 14 May 2018 15:34:43 +0530
Subject: [PATCH] ARM: dts: da850-lego-ev3: remove unnecessary gpio-keys
 properties
In-Reply-To: <20180512214159.22041-1-david@lechnology.com>
References: <20180512214159.22041-1-david@lechnology.com>
Message-ID: <95feb477-cd17-54e2-4a99-62a8a5e6f993@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 13 May 2018 03:11 AM, David Lechner wrote:
> This removes the #address-cells and #size-cells properties from the
> gpio-keys node in the da850-lego-ev3 device tree. These properties are
> not needed since the child nodes don't have a reg property.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Applied to v4.18/dt. Its too late to sent W=1 warning fixes for v4.17 cycle.

Thanks,
Sekhar
