From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 20 Aug 2015 21:48:20 +0200
Subject: [PATCH v2 09/21] ARM: pxa: magician: Add OV9640 camera support
In-Reply-To: <55D259A1.6090102@tul.cz> (Petr Cvek's message of "Tue, 18 Aug
 2015 00:01:05 +0200")
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D259A1.6090102@tul.cz>
Message-ID: <87lhd568sb.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> +	mdelay(3);
Okay, there are several mdelay(3) in this file.

Could you please test if removing these mdelays prevents the camera from working
? If not, I'd like to have them removed.

Cheers.

--
Robert
