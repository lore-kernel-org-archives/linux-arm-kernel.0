From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 3 Nov 2016 09:30:16 +0100
Subject: [PATCH v2 10/14] ASoC: sun4i-codec: Add support for A31 ADC
 capture path
In-Reply-To: <20161103075556.29018-11-wens@csie.org>
References: <20161103075556.29018-1-wens@csie.org>
 <20161103075556.29018-11-wens@csie.org>
Message-ID: <20161103083016.cgxnxtudezdmbhsr@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03, 2016 at 03:55:52PM +0800, Chen-Yu Tsai wrote:
> The A31's internal codec capture path has a mixer in front of the ADC
> for each channel, capable of selecting various inputs, including
> microphones, line in, phone in, and the main output mixer.
> 
> This patch adds the various controls, widgets and routes needed for
> audio capture from the already supported inputs on the A31.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161103/563cf894/attachment-0001.sig>
