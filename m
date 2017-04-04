From: tony@atomide.com (Tony Lindgren)
Date: Tue, 4 Apr 2017 10:43:24 -0700
Subject: [PATCH v4 0/8] mfd: Add OF device table to I2C drivers that are
 missing it
In-Reply-To: <20170404153036.6651-1-javier@osg.samsung.com>
References: <20170404153036.6651-1-javier@osg.samsung.com>
Message-ID: <20170404174323.GA13234@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Javier Martinez Canillas <javier@osg.samsung.com> [170404 08:33]:
> Most patches can be applied independently, with the exception of patches
> 2 to 4 that should be applied in the same tree to keep bisect-ability.

Probably best to merge this all via MFD or i2c:

Acked-by: Tony Lindgren <tony@atomide.com>
