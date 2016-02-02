From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 2 Feb 2016 14:19:47 +0100
Subject: [PATCH 06/14] ARM: dts: sun8i-a83t: Correct low speed oscillator
 clocks
In-Reply-To: <1454203266-4450-7-git-send-email-vishnupatekar0510@gmail.com>
References: <1454203266-4450-1-git-send-email-vishnupatekar0510@gmail.com>
 <1454203266-4450-7-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <20160202131947.GS4652@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 31, 2016 at 09:20:58AM +0800, Vishnu Patekar wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The A83T does not have a 32.768 kHz low speed oscillator, either as
> an external crystal or input. It has a 16 MHz RC-based (inaccurate)
> internal oscillator, which is then divided by 512 for a clock close
> to 32 kHz.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

You should have your SoB here.

Is it ok to add it?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160202/7ce85e61/attachment.sig>
