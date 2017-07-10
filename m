From: robh@kernel.org (Rob Herring)
Date: Sun, 9 Jul 2017 20:02:03 -0500
Subject: [PATCH v2 7/9] ASoC: atmel-classd: remove aclk clock from DT
 binding
In-Reply-To: <20170704115927.32662-8-quentin.schulz@free-electrons.com>
References: <20170704115927.32662-1-quentin.schulz@free-electrons.com>
 <20170704115927.32662-8-quentin.schulz@free-electrons.com>
Message-ID: <20170710010203.u54wtave2a3x2ke6@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 04, 2017 at 01:59:25PM +0200, Quentin Schulz wrote:
> Since gclk (generated-clk) is now able to determine the rate of the
> audio_pll, there is no need for classd to have a direct phandle to the
> audio_pll while already having a phandle to gclk.
> 
> This binding is used by no board in mainline so it is safe to be
> modified.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
> 
> added in v2
> 
>  Documentation/devicetree/bindings/sound/atmel-classd.txt | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
