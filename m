From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 02 Apr 2015 11:06:32 +0200
Subject: [PATCH 3/5] dmaengine: pxa: add pxa dmaengine driver
In-Reply-To: <1426977868-5414-4-git-send-email-robert.jarzmik@free.fr> (Robert
 Jarzmik's message of "Sat, 21 Mar 2015 23:44:26 +0100")
References: <1426977868-5414-1-git-send-email-robert.jarzmik@free.fr>
 <1426977868-5414-4-git-send-email-robert.jarzmik@free.fr>
Message-ID: <87k2xuucfb.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> This is a new driver for pxa SoCs, which is also compatible with the former
> mmp_pdma.

All right, I have a v2 for this patch, with a minor change for muxed interrupt
probe case (1 interrupt for all channels).

I'll release it this week. Did you have the time to have a look at the patch
serie Vinod ?

Cheers.

--
Robert
