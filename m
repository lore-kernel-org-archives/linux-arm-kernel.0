From: olof@lixom.net (Olof Johansson)
Date: Tue, 22 Feb 2011 13:00:57 -0800
Subject: [PATCH 1/6] ARM: tegra: add tegra_gpio_table and tegra_gpio_config
In-Reply-To: <20110222204654.GD29559@n2100.arm.linux.org.uk>
References: <1298354117-19097-1-git-send-email-olof@lixom.net>
	<1298354117-19097-2-git-send-email-olof@lixom.net>
	<20110222204654.GD29559@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=e5xYq=RnVE4mS6bziUM0wkn=UQ780t9y2+_3H@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 22, 2011 at 12:46 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Feb 21, 2011 at 11:55:12PM -0600, Olof Johansson wrote:
>> ?#include <linux/kernel.h>
>> ?#include <mach/pinmux.h>
>> +#include <mach/gpio.h>
>
> linux/gpio.h please

Thanks, fixed.


-Olof
