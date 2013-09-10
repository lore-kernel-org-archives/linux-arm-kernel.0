From: olof@lixom.net (Olof Johansson)
Date: Tue, 10 Sep 2013 08:23:58 -0700
Subject: [PATCH 01/38] ARM: ux500: Remove PrimeCell IDs from Nomadik I2C
 DT nodes
In-Reply-To: <1378817379-8238-2-git-send-email-lee.jones@linaro.org>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
 <1378817379-8238-2-git-send-email-lee.jones@linaro.org>
Message-ID: <CAOesGMgySNLKo_H0h4MCbAWvyW0h2bWa96drWBpnhAYYQwH9mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Sep 10, 2013 at 5:49 AM, Lee Jones <lee.jones@linaro.org> wrote:
> Turns out that they're actually not required and the driver probes just
> fine without them. The ID is incorrect at the moment anyway. They actually
> currently specify the stn8815.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

How did you test this patch? What hardware did you boot it on and with
what config?

Thanks!

-Olof
