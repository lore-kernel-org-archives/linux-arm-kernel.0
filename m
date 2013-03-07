From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 7 Mar 2013 09:14:56 +0100
Subject: [PATCH] ASoC: samsung: let device core setup the default pin
 configuration
In-Reply-To: <1362570951-14403-1-git-send-email-thomas.abraham@linaro.org>
References: <1362570951-14403-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <CACRpkdYF7ed-+Qkw_+N2rHzOv1njkGLew+7wcSYsOGvooeAVCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 6, 2013 at 12:55 PM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:

> With device core now able to setup the default pin configuration,
> the pin configuration code based on the deprecated Samsung specific
> gpio bindings in i2s driver is removed.
>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
