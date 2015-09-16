From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 16 Sep 2015 21:20:24 +0200
Subject: [PATCH 1/3] dmaengine: virt-dma: don't always free descriptor
 upon completion
In-Reply-To: <878u8bu6nh.fsf@belgarion.home> (Robert Jarzmik's message of
 "Sat, 12 Sep 2015 15:08:34 +0200")
References: <1441539654-19055-1-git-send-email-robert.jarzmik@free.fr>
 <878u8bu6nh.fsf@belgarion.home>
Message-ID: <87613arx1j.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> Robert Jarzmik <robert.jarzmik@free.fr> writes:
> Hi Jun, Lars-Peter and Vinod,
>
> The revert of the former patch of this type, 8c8fe97b2b8a ("Revert "dmaengine:
> virt-dma: don't always free descriptor upon completion"") broke pxa_dma
> driver.

So ... what's the plan, Vinod ? I need to fix pxa-dma driver in the early -rc
stages, how does it work with your schedule ?

Cheers.

--
Robert
