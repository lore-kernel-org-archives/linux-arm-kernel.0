From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 28 Aug 2013 11:03:54 +0200
Subject: [PATCH v3 4/6] iio: at91: ADC start-up time calculation changed
 since at91sam9x5
In-Reply-To: <1377602932-1899-5-git-send-email-josh.wu@atmel.com>
References: <1377602932-1899-1-git-send-email-josh.wu@atmel.com>
 <1377602932-1899-5-git-send-email-josh.wu@atmel.com>
Message-ID: <20130828090354.GP2695@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Josh,

On Tue, Aug 27, 2013 at 07:28:50PM +0800, Josh Wu wrote:
> Since in at91sam9x5, sama5d3x chip. the start up time calucation is changed.
> This patch can choose different start up time calculation formula for different
> chips.
> 
> Signed-off-by: Josh Wu <josh.wu@atmel.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks for your work,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130828/29aaa6f1/attachment.sig>
