From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 30 Aug 2012 00:38:41 +0100
Subject: [PATCH 06/10] ARM: shmobile: explicitly include mach/gpio.h
In-Reply-To: <1346279496-26286-7-git-send-email-robherring2@gmail.com>
References: <1346279496-26286-1-git-send-email-robherring2@gmail.com>
 <1346279496-26286-7-git-send-email-robherring2@gmail.com>
Message-ID: <20120829233841.GU18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2012 at 05:31:32PM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> In preparation to remove implicit inclusion of mach/gpio.h, add explict
> includes of necessary headers.
> 
> shmobile always uses gpiolib, so we can remove some of mach/gpio.h.

Given that I spent a long time getting rid of all explicit mach/gpio.h
includes to fix the madness with what definitions drivers picked up from
where, NAK.
