From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 7 Mar 2013 09:11:53 +0100
Subject: [PATCH] spi: s3c64xx: let device core setup the default pin
 configuration
In-Reply-To: <1362570130-14084-1-git-send-email-thomas.abraham@linaro.org>
References: <1362570130-14084-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <CACRpkdb7r9e_O1O_fbAPs=zF+nm9UkV9zDchAW4HuJJ7A9a33w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 6, 2013 at 12:42 PM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:

> With device core now able to setup the default pin configuration,
> the pin configuration code based on the deprecated Samsung specific
> gpio bindings is removed.
>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
