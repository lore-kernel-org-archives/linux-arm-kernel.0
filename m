From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 25 Nov 2016 09:12:09 +0100
Subject: [PATCH resend v3] ASoC: sun4i-codec: Add "Right Mixer" to "Line
 Out Mono Diff." route
In-Reply-To: <20161124114649.5188-1-wens@csie.org>
References: <20161124114649.5188-1-wens@csie.org>
Message-ID: <20161125081209.adjtlxdlcfitk2tg@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2016 at 07:46:49PM +0800, Chen-Yu Tsai wrote:
> The mono differential output for "Line Out" downmixes the stereo audio
> from the mixer, instead of just taking the left channel.
> 
> Add a route from the "Right Mixer" to "Line Out Source Playback Route"
> through the "Mono Differential" path, so DAPM doesn't shut down
> everything if the left channel is muted.
> 
> Fixes: 0f909f98d7cb ("ASoC: sun4i-codec: Add support for A31 Line Out
> 		      playback")
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161125/9e1a3418/attachment.sig>
