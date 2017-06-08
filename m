From: guodong.xu@linaro.org (Guodong Xu)
Date: Thu, 8 Jun 2017 09:01:59 +0800
Subject: [PATCH v5 6/8] regulator: hi6421: Describe consumed platform
 device
In-Reply-To: <20170607192524.ggci4pn47smrduex@sirena.org.uk>
References: <20170607070606.8889-1-guodong.xu@linaro.org>
 <20170607070606.8889-7-guodong.xu@linaro.org>
 <20170607192524.ggci4pn47smrduex@sirena.org.uk>
Message-ID: <CAFGCpxzHCX6uatj4+T0muJaHOyhx1RkQrNpzNv+wm=BY5AN7wQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 8, 2017 at 3:25 AM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Jun 07, 2017 at 03:06:04PM +0800, Guodong Xu wrote:
>> The hi6421-regulator driver consumes a similarly named platform device.
>> Adding that to the module device table, allows modprobe to locate this
>> driver once the device is created.
>
> You need this in hi6421v530 too.

I will add that in v6.
Thanks, Mark.

-Guodong
