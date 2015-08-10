From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Aug 2015 11:38:34 +0200
Subject: [PATCH 3/6] gpiolib-of: Reuse 'line-name' from DT as gpio
 descriptor name
In-Reply-To: <1438680203-13432-4-git-send-email-mpa@pengutronix.de>
References: <1438680203-13432-1-git-send-email-mpa@pengutronix.de>
 <1438680203-13432-4-git-send-email-mpa@pengutronix.de>
Message-ID: <CACRpkdY+jOxZY4_uvhQ75nKkoA2hJ7k=cv2OZwv4D86Jn4QnGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 4, 2015 at 11:23 AM, Markus Pargmann <mpa@pengutronix.de> wrote:

> The DT describes gpios with subnodes. These subnodes can contain a
> property 'line-name'. This information can be useful in other areas
> where we want to identify a GPIO by its name.
>
> This patch stores the line-name in the gpio descriptor.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

This patch looks correct given the context works as intended.

Yours,
Linus Walleij
