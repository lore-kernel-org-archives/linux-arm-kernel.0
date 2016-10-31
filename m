From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 31 Oct 2016 09:37:17 +0100
Subject: [PATCH 5/9] ASoC: pxa: switch to new ac97 bus support
In-Reply-To: <1477510907-23495-6-git-send-email-robert.jarzmik@free.fr>
 (Robert Jarzmik's message of "Wed, 26 Oct 2016 21:41:43 +0200")
References: <1477510907-23495-1-git-send-email-robert.jarzmik@free.fr>
 <1477510907-23495-6-git-send-email-robert.jarzmik@free.fr>
Message-ID: <87bmy029tu.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> Switch to the new ac97 bus support in sound/ac97 instead of the legacy
> snd_ac97 one.
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
I realized this one impacts sound/arm/pxa2xx-ac97.c.
This deserves a v2, with this patch being split into 2 pieces :
 - one for pxa2xx-ac97-lib.*
 - one which will be the true switch to the new ac97 bus.

Cheers.

--
Robert
