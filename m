From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 15 Dec 2017 15:43:07 +0100
Subject: [PATCH v2 0/3] ARM: sun8i: a83t: Add support for I2S and I2C
In-Reply-To: <20171214042350.29469-1-wens@csie.org>
References: <20171214042350.29469-1-wens@csie.org>
Message-ID: <20171215144307.t7fyb3fzc7rqwthr@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 14, 2017 at 12:23:47PM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
> 
> This is v2 of my A83T I2S and I2C support series.
> 
> Changes since v1:
> 
>   - Dropped ASoC patch that was merged
>   - Added SoC-specific compatible strings for I2C controllers
>   - Added Maxime's Acked-by
> 
> This series adds support for I2S and I2C on the Allwinner A83T SoC.
> The I2S controllers are similar to the ones found on the A31. However
> the TX FIFO and interrupt status registers were swapped around. This
> seems to be a recurring theme for the audio related hardware blocks.
> 
> Patch 1 adds device nodes and default pinmux settings for the I2S
> controllers.
> 
> Patch 2 adds device nodes and default pinmux settings for the I2C
> controllers.

Applied both, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171215/a8650e39/attachment.sig>
