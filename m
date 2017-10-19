From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Oct 2017 22:55:17 +0200
Subject: [PATCH] ARM: defconfig: select the right SX150X driver
In-Reply-To: <20171017093208.5313-1-linus.walleij@linaro.org>
References: <20171017093208.5313-1-linus.walleij@linaro.org>
Message-ID: <CAK8P3a3Ftenw7eExxCVRpx-_U3eE2YqdGFjT9kirKUYAOEdpnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 11:32 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> The SX150X GPIO expander has been moved to pin control and
> its Kconfig symbol has been renamed. We used to have a paper-over
> thing in Kconfig but it was causing circular dependencies so
> I have had to kill it off. Select the right driver instead.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: please apply this directly for ARM SoC.

Applied to next/soc, thanks!

     Arnd
