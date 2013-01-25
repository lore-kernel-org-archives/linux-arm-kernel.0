From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Fri, 25 Jan 2013 13:21:12 +0100
Subject: [PATCH 1/2] ARM: dts: omap3-overo: Add support for pwm-leds
In-Reply-To: <5102756A.9040901@ti.com>
References: <1358963812-19947-1-git-send-email-florian.vaussard@epfl.ch>
 <1358963812-19947-2-git-send-email-florian.vaussard@epfl.ch>
 <5101510C.9050407@ti.com> <51015663.8080109@epfl.ch>
 <5101570A.1030303@ti.com> <5101663C.7020301@epfl.ch> <51016A84.20703@ti.com>
 <5101A43D.7080108@epfl.ch> <51024254.40208@ti.com> <5102756A.9040901@ti.com>
Message-ID: <510278B8.40809@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>
>> We have two drivers at the moment: pwm-twl and pwm-twl-led. However new out of
>> SoC PWM drivers might come (for example for palmas). So it worth take a look
>> at some generic implementation.
>
> OK. So I have the series. I need to add few more things but pwm-leds on
> BeagleBoard works fine when I put the default_trigger for the pmustat LED to
> be mmc0. It is blinking happily ;)
> I'll CC you with the patches when I send them.
>

I sent a patchset 2 hours ago with you in CC, you haven't received them?

Cheers,

Florian
