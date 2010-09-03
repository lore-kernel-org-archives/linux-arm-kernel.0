From: viresh.kumar@st.com (viresh kumar)
Date: Fri, 3 Sep 2010 09:14:44 +0530
Subject: [PATCH 14/74] ST SPEAr: Adding PLGPIO driver for spear platform
In-Reply-To: <20100902091341.GI26319@n2100.arm.linux.org.uk>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<ee98dfb49c1634d60fe2fe4f8aabca183be08d24.1283161023.git.viresh.kumar@st.com>
	<20100902091341.GI26319@n2100.arm.linux.org.uk>
Message-ID: <4C806F2C.8020000@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/2/2010 2:43 PM, Russell King - ARM Linux wrote:
>> +#include <linux/gpio.h>
>> > +#include <linux/slab.h>
>> > +#include <linux/platform_device.h>
>> > +#include <mach/gpio.h>
> You're already including linux/gpio.h, which means mach/gpio.h will already
> be included.
> .
> 

Correct. Will remove mach/gpio.h
