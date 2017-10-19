From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Oct 2017 23:52:24 +0200
Subject: [PATCH v2] ARM: dts: Add TVE200 to the Gemini SoC DTSI
In-Reply-To: <20171011174519.1769-1-linus.walleij@linaro.org>
References: <20171011174519.1769-1-linus.walleij@linaro.org>
Message-ID: <CAK8P3a2sqU-wSJ0hH0BAUQ67VkZh5O6BnkkVEqUOGOuFaPHLDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 11, 2017 at 7:45 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> The Faraday TVE200 is present in the Gemini SoC, sometimes
> under the name "TVC". Add it to the SoC DTSI file along with
> its resources.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks:
>
> Please apply this directly to some DT branch. I am not
> planning any more Gemini DTS patches for v4.15.

Applied to next/dt, thanks!

     Arnd
