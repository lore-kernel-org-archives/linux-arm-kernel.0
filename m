From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 23 Jan 2016 19:01:04 +0100
Subject: [PATCH 0/4] rotary-encoder: use generic device properties
In-Reply-To: <1453138902-11657-1-git-send-email-dmitry.torokhov@gmail.com>
 (Dmitry Torokhov's message of "Mon, 18 Jan 2016 09:41:38 -0800")
References: <1453138902-11657-1-git-send-email-dmitry.torokhov@gmail.com>
Message-ID: <87r3h8b2fz.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:

> Hi,
>
> This series tries to move the driver away from legacy platform data towards
> using platform-independent way of retrieving both configuration parameters and
> GPIOs (device_property_read_* and gpiod APIs).
>
> This is based on top of 2 Timo's patches converting the driver to use devm* API
> and threaded IRQs. I uploaded all changes into 'rotary-encoder' branch of my
> tree.
>
> I do not have hard ware so please give it a spin, especially on raumfield as it
> uses branch new way of passing platform parameters to the driver.

Hi Dmitry,

>From the pxa architecture point of view, it looks fine to me.
Daniel, I seem to remember you had this raumfeld hardware, would you have the
opportunity to give this serie a try ?

Cheers.

-- 
Robert
