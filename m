From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 20 Jun 2018 22:26:11 +0200
Subject: [PATCH] ARM: pxa: zylonite: use the new ac97 bus support
In-Reply-To: <20180603201702.15919-1-robert.jarzmik@free.fr> (Robert Jarzmik's
 message of "Sun, 3 Jun 2018 22:17:02 +0200")
References: <20180603201702.15919-1-robert.jarzmik@free.fr>
Message-ID: <87zhzpnr18.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> Now the PXA is converted to new ac97 bus support, the wm9713 is
> automatically detected and probed. Remove it from the platform bus.
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>  arch/arm/mach-pxa/zylonite.c | 11 -----------
>  1 file changed, 11 deletions(-)
Queued to pxa/for-next.

--
Robert
