From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 10 Sep 2013 16:30:37 +0100
Subject: [PATCH 01/38] ARM: ux500: Remove PrimeCell IDs from Nomadik I2C
 DT nodes
In-Reply-To: <CAOesGMgySNLKo_H0h4MCbAWvyW0h2bWa96drWBpnhAYYQwH9mw@mail.gmail.com>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
 <1378817379-8238-2-git-send-email-lee.jones@linaro.org>
 <CAOesGMgySNLKo_H0h4MCbAWvyW0h2bWa96drWBpnhAYYQwH9mw@mail.gmail.com>
Message-ID: <20130910153037.GA11227@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Tue, Sep 10, 2013 at 5:49 AM, Lee Jones <lee.jones@linaro.org> wrote:
> > Turns out that they're actually not required and the driver probes just
> > fine without them. The ID is incorrect at the moment anyway. They actually
> > currently specify the stn8815.
> >
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> How did you test this patch? What hardware did you boot it on and with
> what config?

Snowball, u8500_defconfig.

Why? Don't you have the same result with yours?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
