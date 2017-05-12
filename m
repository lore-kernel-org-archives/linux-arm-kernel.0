From: robh@kernel.org (Rob Herring)
Date: Fri, 12 May 2017 10:30:04 -0500
Subject: [PATCH 2/4] ata: Add DT bindings for the Gemini SATA bridge
In-Reply-To: <20170506121053.11554-2-linus.walleij@linaro.org>
References: <20170506121053.11554-1-linus.walleij@linaro.org>
 <20170506121053.11554-2-linus.walleij@linaro.org>
Message-ID: <20170512153004.3zbicfotgr4ehptm@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 06, 2017 at 02:10:51PM +0200, Linus Walleij wrote:
> This adds device tree bindings for the Cortina Systems Gemini
> PATA to SATA bridge.
> 
> Cc: devicetree at vger.kernel.org
> Cc: John Feng-Hsin Chiang <john453@faraday-tech.com>
> Cc: Greentime Hu <green.hu@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../bindings/ata/cortina,gemini-sata-bridge.txt    | 55 ++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.txt

Acked-by: Rob Herring <robh@kernel.org>
