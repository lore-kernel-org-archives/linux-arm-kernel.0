From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 23 Oct 2018 14:01:41 +0200 (CEST)
Subject: [PATCH] thermal: bcm2835: enable hwmon explicitly
In-Reply-To: <20181021215848.5827-1-matthias.bgg@kernel.org>
References: <20181021215848.5827-1-matthias.bgg@kernel.org>
Message-ID: <459136891.184150.1540296101955@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

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

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

I'm just curious which board and config did you use for your tests?

Regards
Stefan
