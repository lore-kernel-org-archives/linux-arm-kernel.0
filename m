From: syin@broadcom.com (Sherman Yin)
Date: Wed, 18 Dec 2013 16:12:30 -0800
Subject: [PATCH v3 5/6] ARM: pinctrl: Add Broadcom Capri pinctrl driver
In-Reply-To: <20131213102252.GS11044@sirena.org.uk>
References: <1381174108-25168-1-git-send-email-syin@broadcom.com>
 <1386787041-6035-1-git-send-email-syin@broadcom.com>
 <1386787041-6035-6-git-send-email-syin@broadcom.com>
 <CACRpkdaeZCodKv6R+4ZS3o-5u=QQuV3JidEp7uaLsN9aYG7bqA@mail.gmail.com>
 <20131213102252.GS11044@sirena.org.uk>
Message-ID: <52B239EE.6010601@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-12-13 02:22 AM, Mark Brown wrote:
> On Thu, Dec 12, 2013 at 09:54:50PM +0100, Linus Walleij wrote:
>
>> This is a reimplementation of regmap for MMIO.
>> See drivers/base/regmap/regmap-mmio.c
>> Notice how regmap_update_bits() is used throughout the
>> kernel.
>
>> If you want to do this, use regmap.
>
> Or if this is very performance sensitive (which I'd not expect for
> pinctrl) there's a helper in review at the minute which just uses a
> spinlock.
>

Thanks Mark.  It's not expected to be performance sensitive, so I'll 
probably go with regmap.

Regards,
Sherman
