From: tony@atomide.com (Tony Lindgren)
Date: Thu, 26 Jan 2012 15:31:50 -0800
Subject: [PATCH v2] GPMC: fix device size setup
In-Reply-To: <4F1D0D07.7070807@visionsystems.de>
References: <4F1D0D07.7070807@visionsystems.de>
Message-ID: <20120126233150.GC29812@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Yegor Yefremov <yegor_sub1@visionsystems.de> [120122 23:01]:
> following statement can only change device size from 8-bit(0) to 16-bit(1),
> but not vice versa:
> 
> regval |= GPMC_CONFIG1_DEVICESIZE(wval);
> 
> so as this field has 1 reserved bit, that could be used in future,
> just clear both bits and then OR with the desired value

Thanks applying into fixes.

Tony
