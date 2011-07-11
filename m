From: bryan.wu@canonical.com (Bryan Wu)
Date: Mon, 11 Jul 2011 22:02:01 +0800
Subject: [PATCH 04/17] mach-versatile: retire custom LED code
In-Reply-To: <20110710092836.GT4812@n2100.arm.linux.org.uk>
References: <1309955687-19365-1-git-send-email-bryan.wu@canonical.com>
	<1309955687-19365-5-git-send-email-bryan.wu@canonical.com>
	<20110710092836.GT4812@n2100.arm.linux.org.uk>
Message-ID: <CAK5ve-KwL4rX65FqyWcZrvAcx0vFcGDpWQXgm67P8n2MDpNHWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 10, 2011 at 5:28 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Jul 06, 2011 at 08:34:34PM +0800, Bryan Wu wrote:
>> From: Linus Walleij <linus.walleij@linaro.org>
>>
>> The CPU activity LED is now handled by the trigger in the leds
>> subsystem, retire this old CONFIG_LEDS-based code.
>
> Shouldn't this be part of the previous patch? ?The previous patch changes
> both Realview and Versatile by touching plat-versatile.
>

I will fold them together, if Linus has no problem about it.

Thanks,
-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer ? ?+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. ? ? ?www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
