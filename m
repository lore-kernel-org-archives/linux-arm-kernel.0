From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 20 Jun 2018 22:21:30 +0200
Subject: [PATCH] ARM: pxa: hx4700: fix the usb client
In-Reply-To: <20180526093834.21277-1-robert.jarzmik@free.fr> (Robert Jarzmik's
 message of "Sat, 26 May 2018 11:38:34 +0200")
References: <20180526093834.21277-1-robert.jarzmik@free.fr>
Message-ID: <87d0wlp5th.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> The usb client of the hx4700 is not working because no platform data is
> declared. Fix it by adding the missing call.
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Queued to pxa/for-next.

--
Robert
