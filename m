From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 7 Mar 2013 09:15:56 +0100
Subject: [PATCH 0/2] ARM: dts: Add default pin states for client nodes on
 Exynos4/5 platforms
In-Reply-To: <1362573398-15126-1-git-send-email-thomas.abraham@linaro.org>
References: <1362573398-15126-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <CACRpkdbsCpV5_P=z44CMvsgps=AS9C62oprn6To6ExhoWZkvhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 6, 2013 at 1:36 PM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:

> This patch series populates the default pin states in client nodes
> of Exynos4 and Exynos5 platforms. Exynos4/5 platforms are migrating
> to use pinctrl framework and having the default pin states listed
> in the client nodes allows the device core to setup the default
> pin configuration for all the controllers.

The series:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
