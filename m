From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 9 Jul 2012 12:55:51 +0200
Subject: [PATCH 0/4 V5] add 88pm80x mfd driver
In-Reply-To: <1341815855-13522-1-git-send-email-zhouqiao@marvell.com>
References: <1341815855-13522-1-git-send-email-zhouqiao@marvell.com>
Message-ID: <20120709105551.GK15345@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zhou,

On Mon, Jul 09, 2012 at 02:37:31PM +0800, Qiao Zhou wrote:
> change log [v5->v4]:
> 1, change the file name, from 88pm800-core.c, 88pm805-core.c, 88pm80x-i2c.c
> to 88pm800.c, 88pm805.c, 88pm80x.c, and modified Makefile accordingly.
> 2, replace the spinlock used to protect wakeup flag, with using set_bit/
> clear_bit, which is suitable adn enough in SMP env.
> 3, add the version number in each patch.
I applied the first 2 patches, I'd like to get an ACK from the respective
maintainers for the rtc and the input ones. They can even take it as both
drivers are protected by the MFD symbol.

Cheers,
Samuel. 

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
