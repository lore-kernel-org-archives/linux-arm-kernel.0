From: robh@kernel.org (Rob Herring)
Date: Sun, 18 Feb 2018 21:05:38 -0600
Subject: [PATCH 1/9] dt-bindings: power: Fix "debounce-interval" property
 misspelling
In-Reply-To: <1518531335-5170-2-git-send-email-geert+renesas@glider.be>
References: <1518531335-5170-1-git-send-email-geert+renesas@glider.be>
 <1518531335-5170-2-git-send-email-geert+renesas@glider.be>
Message-ID: <20180219030538.yioxsjaemoecxysk@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 13, 2018 at 03:15:27PM +0100, Geert Uytterhoeven wrote:
> "debounce_interval" was never supported.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
> Please apply to your tree when appropriate.

Done.

> 
>  Documentation/devicetree/bindings/power/wakeup-source.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
