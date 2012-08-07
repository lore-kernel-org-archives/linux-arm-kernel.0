From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 7 Aug 2012 15:18:56 +0800
Subject: [PATCH 1/6] ARM: mxs: tx28: reset fec phy for device tree boot
In-Reply-To: <CAP9ODKqLzfSRFMjg6yrmzTviNv4R3EyD0Sa2TMnWvKL0Djyj=Q@mail.gmail.com>
References: <1344267769-31166-1-git-send-email-shawn.guo@linaro.org>
 <1344267769-31166-2-git-send-email-shawn.guo@linaro.org>
 <CAP9ODKqLzfSRFMjg6yrmzTviNv4R3EyD0Sa2TMnWvKL0Djyj=Q@mail.gmail.com>
Message-ID: <20120807071853.GA13964@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 06, 2012 at 01:51:07PM -0300, Otavio Salvador wrote:
> On Mon, Aug 6, 2012 at 12:42 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > For non-DT boot, function tx28_add_fec0 configures all ENET0 pins
> > into gpio mode for resetting fec phy, and then reconfigures those pins
> > into ENET function after that.
> >
> > For DT boot, all the pin configuration is done by pinctrl subsystem.
> > Ideally, when gpio_requst gets called, GPIO subsystem should call
> 
>                         ^ typo
> 
Fixed.  Thanks, Otavio.

-- 
Regards,
Shawn
