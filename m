From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 13 Mar 2015 11:33:29 +0100
Subject: [PATCH v5 00/10] Atmel System Timer cleanups
In-Reply-To: <5502BA89.8020100@linaro.org>
References: <1426162054-9987-1-git-send-email-alexandre.belloni@free-electrons.com>
 <5502BA89.8020100@linaro.org>
Message-ID: <20150313103329.GF4329@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/03/2015 at 11:23:05 +0100, Daniel Lezcano wrote :
> On 03/12/2015 01:07 PM, Alexandre Belloni wrote:
> >This patch set cleans up the system timer driver.
> >
> >The main goal is to get rid of the mach/ headers dependency. At the same time,
> >it introduces proper probing and locking (using a regmap) for the watchdog
> >driver.
> >
> >This is based on 4.0-rc1 and will have two merge conflicts with my cleanup #1 in
> >mach-at91/at91rm9200.c
> >
> >It also needs this patch to probe the watchdog properly:
> >http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/327274.html
> 
> 
> Hi Alexandre,
> 
> through which tree do you want this patchset to be merged ?
> 

I'd say through the at91 tree as I have another series that depend on
that one


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
