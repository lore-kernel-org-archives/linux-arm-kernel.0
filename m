From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 13:39:06 +0200
Subject: [PATCH 28/32] ARM: ux500: Pass remnant platform data though to
 DMA40 driver
In-Reply-To: <1366279934-30761-29-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-29-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYrpxt0DZutX=XhYUoj112+m26h60WO-Yf8BOo+ONfNHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 12:12 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Ironically, in order to remove lots of the auxdata assignments, we have
> to add just one more. A lot of them require DMA information to be passed
> into clients for DMA channel allocation, but we now have this capability
> in Device Tree. However, the DMA40 driver still relies on a reverse table
> look-up to obtain DMA addresses. Until all of the clients are converted,
> over to the new API, we're stuck with this.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

As mentioned merge into patch 27, then ACK.

Yours,
Linus Walleij
