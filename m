From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 May 2013 21:37:04 +0200
Subject: [PATCH 06/63] ARM: ux500: Pass DMA memcpy channels though Device
 Tree
In-Reply-To: <1367591569-32197-7-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
 <1367591569-32197-7-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZ+srX-gEimgNYBgvK-qGBGorM4EygWgGdDXBhtBaTFcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 3, 2013 at 4:31 PM, Lee Jones <lee.jones@linaro.org> wrote:

> It's now possible to configure memcpy channels dynamically with DT.
> We're providing them despite the fact that they're the same as the
> hard-coded channels, as they will be removed once the u8500 platform
> goes DT-only.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied to my ux500-devicetree branch.

Thanks!
Linus Walleij
