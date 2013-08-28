From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 28 Aug 2013 10:56:31 +0200
Subject: [PATCH v3 3/6] iio: at91: Use different prescal, startup mask in
 MR for different IP
In-Reply-To: <1377602932-1899-4-git-send-email-josh.wu@atmel.com>
References: <1377602932-1899-1-git-send-email-josh.wu@atmel.com>
 <1377602932-1899-4-git-send-email-josh.wu@atmel.com>
Message-ID: <20130828085631.GO2695@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Josh,


On Tue, Aug 27, 2013 at 07:28:49PM +0800, Josh Wu wrote:
> For at91 boards, there are different IPs for adc. Different IPs has different
> STARTUP & PRESCAL mask in ADC_MR.
> 
> Signed-off-by: Josh Wu <josh.wu@atmel.com>

It looks fine.

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130828/182cee81/attachment.sig>
