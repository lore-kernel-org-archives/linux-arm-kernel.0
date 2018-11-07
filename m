From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 7 Nov 2018 20:04:44 +0100 (CET)
Subject: [PATCH] thermal: bcm2835: enable hwmon explicitly
In-Reply-To: <20181021215848.5827-1-matthias.bgg@kernel.org>
References: <20181021215848.5827-1-matthias.bgg@kernel.org>
Message-ID: <1393364689.141956.1541617484605@email.ionos.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rui,
hi Eduardo,
hi Daniel,

> matthias.bgg at kernel.org hat am 21. Oktober 2018 um 23:58 geschrieben:
> 
> 
> From: Matthias Brugger <mbrugger@suse.com>
> 
> By defaul of-based thermal driver do not enable hwmon.
> This patch does this explicitly, so that the temperature can be read
> through the common hwmon sysfs.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> ---

any objections except of the missing t in default?

Stefan
