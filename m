From: tony@atomide.com (Tony Lindgren)
Date: Fri, 7 Sep 2018 09:56:22 -0700
Subject: [PATCH 0/3] ARM: OMAP1: ams-delta: Clean up GPIO setup for MODEM
In-Reply-To: <20180820181333.2527-1-jmkrzyszt@gmail.com>
References: <20180820181333.2527-1-jmkrzyszt@gmail.com>
Message-ID: <20180907165622.GI5662@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Janusz Krzysztofik <jmkrzyszt@gmail.com> [180820 11:16]:
> 
> Convert modem related GPIO setup from integer space to GPIO descriptors.
> Also, restore original initialization order of the MODEM device and its
> related GPIO pins.
> 
> Cleanup of MODEM relaated regulator setup is postponed while waiting for
> upcoming conversion of fixed regulator API to GPIO descriptors.
> 
> 
> Janusz Krzysztofik (3):
>       ARM: OMAP1: ams-delta: assign MODEM IRQ from GPIO descriptor
>       ARM: OMAP1: ams-delta: initialize latch2 pins to safe values
>       ARM: OMAP1: ams-delta: register MODEM device earlier

Janusz, can you please repost this series based on v4.19-rc1
with Linus' acks?

At least the header file has moved around now.

And as this also conflicts with your earlier patch
"ARM: OMAP1: ams-delta: assign MODEM IRQ from GPIO descriptor"
please repost that too in the same series.

If you have other arch/arm/*omap*/* related patches then
please repost those too, these are the only ones I still had
tagged :)

Regards,

Tony
