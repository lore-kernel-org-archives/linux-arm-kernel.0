From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 19 Jul 2011 18:20:25 +0200
Subject: [PATCH 08/17] mach-integrator: retire custom LED code
In-Reply-To: <20110710093306.GV4812@n2100.arm.linux.org.uk>
References: <1309955687-19365-1-git-send-email-bryan.wu@canonical.com>
	<1309955687-19365-9-git-send-email-bryan.wu@canonical.com>
	<20110710093306.GV4812@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdbp1GanOajE0o_HdZX10rMnoGwyYAJHyVqYY3judHDK2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 10, 2011 at 11:33 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Jul 06, 2011 at 08:34:38PM +0800, Bryan Wu wrote:
>> Use 4 LEDs in baseboard instead of the LED in core module.
>>
>> The CPU activity LED is now handled by the trigger in the leds
>> subsystem, retire this old CONFIG_LEDS-based code.
>
> This is a functional change. ?Integrator CP has four baseboard LEDs.
> I don't remember Integrator AP having those,

I have one here, it has three LEDs: green, yellow, red.
It appears the yellow one wasn't used for anything before.

> but it does have the LED on the core module, which is used for
> CPU activity on all Integrator platforms.

Sounds more intuitive too, if that LED is to be used for anything,
it's for this.

Thanks,
Linus Walleij
