From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 31 Jan 2017 11:35:03 +0100
Subject: [PATCH v3 3/8] ASoC: Add sun8i digital audio codec
In-Reply-To: <20170131100552.27949-4-mylene.josserand@free-electrons.com>
References: <20170131100552.27949-1-mylene.josserand@free-electrons.com>
 <20170131100552.27949-4-mylene.josserand@free-electrons.com>
Message-ID: <20170131103503.pil6lfbjk3nl2imp@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2017 at 11:05:47AM +0100, Myl?ne Josserand wrote:
> Add the sun8i audio codec which handles the digital register of
> A33 codec.
> The driver handles only the basic playback from the DAC to headphones.
> All other features (microphone, capture, etc) will be added later.
> 
> Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170131/ff465080/attachment.sig>
