From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 06 Jun 2010 19:46:37 +0200
Subject: [PATCH 2/3] pxa: Fix all devices using wm97xx_batt.h
In-Reply-To: <1275613654-23918-2-git-send-email-marek.vasut@gmail.com> (Marek
	Vasut's message of "Fri\, 4 Jun 2010 03\:07\:33 +0200")
References: <1275613654-23918-1-git-send-email-marek.vasut@gmail.com>
	<1275613654-23918-2-git-send-email-marek.vasut@gmail.com>
Message-ID: <87pr04oxz6.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Vasut <marek.vasut@gmail.com> writes:

> This file is scheduled for removal, therefore fix all devices that use this
> file to use the suggested wm97xx.h and pass platform data properly.
>
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> ---
>  arch/arm/mach-pxa/mioa701.c  |   10 +++++++---
>  arch/arm/mach-pxa/palmld.c   |   19 ++++++++++---------
>  arch/arm/mach-pxa/palmt5.c   |   19 ++++++++++---------
>  arch/arm/mach-pxa/palmte2.c  |   20 ++++++++++++--------
>  arch/arm/mach-pxa/palmtreo.c |    1 -
>  arch/arm/mach-pxa/palmtx.c   |   19 ++++++++++---------
>  arch/arm/mach-pxa/palmz72.c  |   20 ++++++++++++--------
>  7 files changed, 61 insertions(+), 47 deletions(-)

For mioa701:
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
