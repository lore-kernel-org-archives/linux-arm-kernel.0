From: robh@kernel.org (Rob Herring)
Date: Tue, 23 May 2017 09:27:39 -0500
Subject: [PATCH 2/3] rtc: gemini: Augment DT bindings for Faraday
In-Reply-To: <20170518215635.13505-2-linus.walleij@linaro.org>
References: <20170518215635.13505-1-linus.walleij@linaro.org>
 <20170518215635.13505-2-linus.walleij@linaro.org>
Message-ID: <20170523142739.34wyhtotl4jldsez@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 18, 2017 at 11:56:34PM +0200, Linus Walleij wrote:
> The Gemini RTC is actually a standard IP block from Faraday
> Technology called FTRTC010. Rename the bindings, add the
> generic compatible string and add definitions for the two
> available clocks.
> 
> Cc: devicetree at vger.kernel.org
> Cc: Po-Yu Chuang <ratbert@faraday-tech.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../devicetree/bindings/rtc/cortina,gemini.txt     | 14 -----------
>  .../devicetree/bindings/rtc/faraday,ftrtc010.txt   | 28 ++++++++++++++++++++++
>  2 files changed, 28 insertions(+), 14 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/rtc/cortina,gemini.txt
>  create mode 100644 Documentation/devicetree/bindings/rtc/faraday,ftrtc010.txt

Acked-by: Rob Herring <robh@kernel.org> 
