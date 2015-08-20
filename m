From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 20 Aug 2015 21:51:45 +0200
Subject: [PATCH v2 10/21] ARM: pxa: magician: Add UDA1380 sound support
In-Reply-To: <55D259B7.90703@tul.cz> (Petr Cvek's message of "Tue, 18 Aug 2015
 00:01:27 +0200")
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D259B7.90703@tul.cz>
Message-ID: <87h9nt68mm.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> +/*
> + * Magician Audio controller
> + */
> +
> +static struct platform_device magician_audio_device = {
> +	.name = "magician-audio",
Is this already upstream or is it a submission in progress ? Other than that
detail, I'll queue it in a week probably.

Cheers.

--
Robert
