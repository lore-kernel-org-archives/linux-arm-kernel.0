From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Apr 2012 18:21:28 +0000
Subject: [PATCH 0/9] Add support for SPEAr13xx SoCs
In-Reply-To: <cover.1334942163.git.viresh.kumar@st.com>
References: <cover.1334942163.git.viresh.kumar@st.com>
Message-ID: <201204201821.28266.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 April 2012, Viresh Kumar wrote:
> Sorry for yet another patchset for you :(
> 
> This one adds in support for SPEAr1310 and SPEAr1340. It supports:
> - DT probing
> - pinctrl drivers
> - common clock framework
> 
> All you requested to get this upstream. :)
> 
> I have CC-ed Linus and Mike for their patches and would ask them for their Acks,
> as this would evantually make through your ARM-SoC tree.
> 
> Few devices/drivers mentioned in dts files have their DT probing patches under
> review.

I've looked at all the platform specific bits and they look pretty good,
great work! I have ignored the pinctrl and clock drivers and hope that the
respective maintainers will be able to judge them well.

There are a few places where you still hardcode stuff that could be turned
into device tree properties, but those are corner cases and you have an
existing platform here that you've done a great amount of excellent cleanups
to in the last weeks, so my feeling is that all the platform code can go in
when you take care of the stuff that I've commented on, most of those things
should be simple.

	Arnd
