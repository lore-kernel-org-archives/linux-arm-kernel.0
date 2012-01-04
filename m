From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 04 Jan 2012 16:59:13 +0400
Subject: [PATCH v8 1/2] davinci: vpif: remove machine specific header
 file inclusion from the driver
In-Reply-To: <1325661469-4411-2-git-send-email-manjunath.hadli@ti.com>
References: <1325661469-4411-1-git-send-email-manjunath.hadli@ti.com>
 <1325661469-4411-2-git-send-email-manjunath.hadli@ti.com>
Message-ID: <4F044D21.1030204@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 04-01-2012 11:17, Manjunath Hadli wrote:

> remove unnecessary inclusion of machine specific header files mach/dm646x.h,
> mach/hardware.h from vpif.h  and aslo mach/dm646x.h from vpif_display.c
> driver which comes in the way of platform code consolidation.
> Add linux/i2c.h header file in vpif_types.h which is required for
> building.

    This last modification should be in a separate patch. Don;t mix changes 
having the different purpose.

> Signed-off-by: Manjunath Hadli<manjunath.hadli@ti.com>
> Cc: Mauro Carvalho Chehab<mchehab@infradead.org>
> Cc: LMML<linux-media@vger.kernel.org>

WBR, Sergei
