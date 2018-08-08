From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 8 Aug 2018 17:55:49 +0200
Subject: [PATCH 00/28] at24: remove at24_platform_data
In-Reply-To: <20180808153150.23444-1-brgl@bgdev.pl>
References: <20180808153150.23444-1-brgl@bgdev.pl>
Message-ID: <20180808155548.s7p4xqsjywz3psrj@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 08, 2018 at 05:31:22PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This is a follow-up to the previously rejected series[1] which partially
> removed the at24_platform_data structure. After further development and
> taking reviews into account, this series finally removes that struct
> completely but not without touching many different parts of the code
> base.
> 
> Since I took over maintainership of the at24 driver I've been working
> towards removing at24_platform_data in favor for device properties.

Wooha, nice work. I can't really comment on it but wondered how you want
to upstream it (after reviews)? Pull request of an immutable branch for
nvmem-tree sounds best to me. Then I could also pull it in if i2c needs
it. Probably same situation for arm-soc...

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180808/845034ad/attachment.sig>
