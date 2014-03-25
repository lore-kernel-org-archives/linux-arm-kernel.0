From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 25 Mar 2014 21:34:21 +0100
Subject: [PATCH 44/62] ARM: integrator: refine CPU selection
In-Reply-To: <201403201148.16239.arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <20140319204946.GK7528@n2100.arm.linux.org.uk>
 <8120199.tJr1GuP6ec@wuerfel> <201403201148.16239.arnd@arndb.de>
Message-ID: <CACRpkdYPvoobHqG4oQaJbrXDZQwYP6H9n7MSuXDt3MonNsC5jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 20, 2014 at 11:48 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> Nevermind, I'll drop this patch for now, I just had an idea to do it
> better: Since Linus and I are trying to get Integrator and Realview
> moved over into ARCH_MULTIPLATFORM anyway, I'll defer the CPU selection
> question until that's done.

Integrator is blocked by one single thing: <mach/memory.h>
bus_to_virt/virt_to_bus.

If we can get some consensus on Santosh's patches
(or however we want to solve that) I'll do multiplatform for
Integrator any day.

Yours,
Linus Walleij
