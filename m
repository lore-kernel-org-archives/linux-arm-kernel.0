From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 3 Nov 2016 09:31:16 +0100
Subject: [PATCH v2 11/14] ASoC: sun4i-codec: Add support for A31 board
 level audio routing
In-Reply-To: <20161103075556.29018-12-wens@csie.org>
References: <20161103075556.29018-1-wens@csie.org>
 <20161103075556.29018-12-wens@csie.org>
Message-ID: <20161103083116.qj2c7yi35wbcergp@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03, 2016 at 03:55:53PM +0800, Chen-Yu Tsai wrote:
> The A31 SoC's codec has various inputs, outputs and microphone bias
> supplies. These can be routed on the board in different ways, such as:
> 
>   - HPCOM may be connected to have the headphone DC coupled.
> 
>   - Microphones all use the MBIAS main microphone supply or one mic may
>     use the HBIAS supply, which supports headset detection and buttons.
> 
>   - Line Out may be routed to an audio jack, or an onboard speaker amp
>     with power controls.
> 
> Add support for specifying the audio routes in the device tree.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161103/73c89dec/attachment.sig>
