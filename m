From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 4 Nov 2011 13:46:44 +0530
Subject: [PATCH] GPIO: spear: remove empty plat/gpio.h
In-Reply-To: <20111104081323.GW12913@n2100.arm.linux.org.uk>
References: <20111103233925.GV12913@n2100.arm.linux.org.uk>
	<4EB35EE6.2050500@st.com>
	<20111104081323.GW12913@n2100.arm.linux.org.uk>
Message-ID: <4EB39F6C.6050406@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/4/2011 1:43 PM, Russell King - ARM Linux wrote:
>> > GPIO: spear: remove empty plat/gpio.h
>> > 
>> > Spear now has an empty plat/gpio.h, and two mach/gpio.h which include
>> > this file.  Simply this by emptying the mach/gpio.h headers, and
>> > getting rid of plat/gpio.h entirely.
>> > 
>> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>> > ---
>> >  arch/arm/mach-spear3xx/include/mach/gpio.h |   20 +-------------------
>> >  arch/arm/mach-spear6xx/include/mach/gpio.h |   20 +-------------------
>> >  arch/arm/plat-spear/include/plat/gpio.h    |    1 -
>> >  3 files changed, 2 insertions(+), 39 deletions(-)
>> >  delete mode 100644 arch/arm/plat-spear/include/plat/gpio.h
>> > 
>> > diff --git a/arch/arm/mach-spear3xx/include/mach/gpio.h b/arch/arm/mach-spear3xx/include/mach/gpio.h
>> > index 451b208..40a8c17 100644
>> > --- a/arch/arm/mach-spear3xx/include/mach/gpio.h
>> > +++ b/arch/arm/mach-spear3xx/include/mach/gpio.h
>> > @@ -1,19 +1 @@
>> > -/*
>> > - * arch/arm/mach-spear3xx/include/mach/gpio.h
>> > - *
>> > - * GPIO macros for SPEAr3xx machine family
>> > - *
>> > - * Copyright (C) 2009 ST Microelectronics
>> > - * Viresh Kumar<viresh.kumar@st.com>
>> > - *
>> > - * This file is licensed under the terms of the GNU General Public
>> > - * License version 2. This program is licensed "as is" without any
>> > - * warranty of any kind, whether express or implied.
>> > - */
>> > -
>> > -#ifndef __MACH_GPIO_H
>> > -#define __MACH_GPIO_H
>> > -
>> > -#include <plat/gpio.h>
>> > -
>> > -#endif /* __MACH_GPIO_H */
>> > +/* empty */
>> > diff --git a/arch/arm/mach-spear6xx/include/mach/gpio.h b/arch/arm/mach-spear6xx/include/mach/gpio.h
>> > index 3a789db..40a8c17 100644
>> > --- a/arch/arm/mach-spear6xx/include/mach/gpio.h
>> > +++ b/arch/arm/mach-spear6xx/include/mach/gpio.h
>> > @@ -1,19 +1 @@
>> > -/*
>> > - * arch/arm/mach-spear6xx/include/mach/gpio.h
>> > - *
>> > - * GPIO macros for SPEAr6xx machine family
>> > - *
>> > - * Copyright (C) 2009 ST Microelectronics
>> > - * Viresh Kumar<viresh.kumar@st.com>
>> > - *
>> > - * This file is licensed under the terms of the GNU General Public
>> > - * License version 2. This program is licensed "as is" without any
>> > - * warranty of any kind, whether express or implied.
>> > - */
>> > -
>> > -#ifndef __MACH_GPIO_H
>> > -#define __MACH_GPIO_H
>> > -
>> > -#include <plat/gpio.h>
>> > -
>> > -#endif /* __MACH_GPIO_H */
>> > +/* empty */
>> > diff --git a/arch/arm/plat-spear/include/plat/gpio.h b/arch/arm/plat-spear/include/plat/gpio.h
>> > deleted file mode 100644
>> > index 40a8c17..0000000
>> > --- a/arch/arm/plat-spear/include/plat/gpio.h
>> > +++ /dev/null
>> > @@ -1 +0,0 @@
>> > -/* empty */
>> > .

Acked-by: Viresh Kumar <viresh.kumar@st.com>

-- 
viresh
