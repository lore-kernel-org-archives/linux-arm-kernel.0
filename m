From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 15:01:23 +0200
Subject: [PATCH 01/10] usb: musb: ux500: move channel number knowledge
 into the driver
In-Reply-To: <1366729394-11406-2-git-send-email-lee.jones@linaro.org>
References: <1366729394-11406-1-git-send-email-lee.jones@linaro.org>
 <1366729394-11406-2-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYs_dZoqfMFbXFPgWd2m4ssn8HO9QZf0+_01fM-YBcDrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that Fabio has written a few patches to this driver I'd like his help
in reviewing this series, can you make sure he gets a copy? Also
please include Praveena and Mian, thanks.

On Tue, Apr 23, 2013 at 5:03 PM, Lee Jones <lee.jones@linaro.org> wrote:

> For all ux500 based platforms the maximum number of end-points are used.
> Move this knowledge into the driver so we can relinquish the burden from
> platform data. This also removes quite a bit of complexity from the driver
> and will aid us when we come to enable the driver for Device Tree.
>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: linux-usb at vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Looks good to me.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
