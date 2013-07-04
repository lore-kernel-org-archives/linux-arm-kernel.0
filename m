From: lars@metafoo.de (Lars-Peter Clausen)
Date: Thu, 04 Jul 2013 11:08:02 +0200
Subject: [PATCHv3 1/3] iio: Add Nuvoton NAU7802 ADC driver
In-Reply-To: <1372094699-3832-2-git-send-email-alexandre.belloni@free-electrons.com>
References: <1372094699-3832-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1372094699-3832-2-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <51D53B72.6020309@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/24/2013 07:24 PM, Alexandre Belloni wrote:
> The Nuvoton NAU7802 ADC is a 24-bit 2-channels I2C ADC, with adjustable
> gain and sampling rates.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

One remark though. Multiline comments should be like

/*
 * foo
 * bar
 */

not

/* foo
 * bar
 */

But not need to resend the patch just for this

- Lars
