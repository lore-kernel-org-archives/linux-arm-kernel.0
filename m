From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Dec 2015 16:12:05 +0100
Subject: [PATCH 3/6] pinctrl: pxa: pxa2xx: add pin muxing
In-Reply-To: <1448129093-20722-4-git-send-email-robert.jarzmik@free.fr>
References: <1448129093-20722-1-git-send-email-robert.jarzmik@free.fr>
 <1448129093-20722-4-git-send-email-robert.jarzmik@free.fr>
Message-ID: <CACRpkdYwFLW1muPDMkdxFxsJ6XOf8wwtwDLbZsWPuWwZb_-hkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 21, 2015 at 7:04 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:

> The driver is inspired from the sunxi driver. The pxa architecture
> specificities leading to the driver are :
>  - each pin has 8 possible alternate functions
>  - 4 of these are output kind
>  - 4 of these are input kind
>  - there is always a "gpio input" and "gpio output" function
>  - the function matrix is very scattered :
>    - some functions can be found on 5 different pads
>    - the number of functions is greater than the number of pins
>    - there is no "topology" grouping of pins (such as all SPI in one
>      corner of the die)
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>

Patch applied.

Yours,
Linus Walleij
