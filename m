From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 3 Nov 2014 22:21:55 +0100
Subject: [PATCH 06/17] gpio: mvebu: add suspend/resume support
In-Reply-To: <5457C119.90809@free-electrons.com>
References: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414151970-6626-7-git-send-email-thomas.petazzoni@free-electrons.com>
 <5457C119.90809@free-electrons.com>
Message-ID: <20141103222155.49bcb7ef@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Mon, 03 Nov 2014 18:53:29 +0100, Gregory CLEMENT wrote:

> I don't know if the suspend is supported on this platform but as we were
> on the road to remove this platform I don't know it it worth testing it unless
> some interested users show up.

The same can be said of the entire mv78xx0 support in gpio-mvebu: it's
completely unused today. Since the migration to mv78xx0 has not been
started, this platform is still using the old style GPIO driver in
plat-orion/gpio.c. And therefore, all the mv78xx0 specific code in
gpio-mvebu.c is purely "tentative" and has never been actually tested
on HW.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
