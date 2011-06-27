From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 Jun 2011 14:37:32 +0200
Subject: [PATCH 0/2] RFC: gpio: driver-local pin configuration
In-Reply-To: <20110627120256.GA19531@opensource.wolfsonmicro.com>
References: <1307695731-28018-1-git-send-email-linus.walleij@stericsson.com>
	<BANLkTinxptCJRETreCpUoV-nU2K4fuFcmQ@mail.gmail.com>
	<BANLkTimMSChGFUSnFWFHv3nNUca_Fyawaw@mail.gmail.com>
	<20110627120256.GA19531@opensource.wolfsonmicro.com>
Message-ID: <BANLkTikpMdakfTU+RRsXQVnpO4-KGkOGJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 27, 2011 at 2:02 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Jun 27, 2011 at 01:44:43PM +0200, Linus Walleij wrote:
>
>> Yes. To make the driver platform neutral, it needs to for example
>> provide a callback in the platform data like (* set_pin_bias) or so,
>> and then your platform has to implement this biasing.
>
>> In this specific case that kind of stuff would likely be preferable
>> to have in the platform anyway, but I understand what you mean.
>
> How about device tree usage? ?I guess there we'd end up doing it by
> putting the configuration on the GPIO end of things rather than on the
> GPIO user side?

Sorry I can't quite understand that, please elaborate!

Thanks,
Linus Walleij
