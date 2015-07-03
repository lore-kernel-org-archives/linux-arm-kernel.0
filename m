From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 03 Jul 2015 22:53:47 +0200
Subject: [PATCH] ARM: mact-pxa: Use module_platform_driver
References: <20150703114656.GA6871@vaishali-Ideapad-Z570>
Message-ID: <871tgparok.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vaishali Thakkar <vthakkar1994@gmail.com> writes:

> Use module_platform_driver for drivers whose init and exit functions
> only register and unregister, respectively.
>
> A simplified version of the Coccinelle semantic patch that performs
> this transformation is as follows:

Applied to pxa/for-next, thanks.
For next time, please use the "ARM: pxa:" subject prefix for arch/arm/mach-pxa
patches. I fixed this for this submission.

Cheers.

--
Robert
