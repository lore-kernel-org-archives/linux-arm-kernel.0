From: marex@denx.de (Marek Vasut)
Date: Fri, 3 Aug 2012 20:46:27 +0200
Subject: [PATCH] MXS: Fix mxs_defconfig MMAP_MIN_ADDR
In-Reply-To: <20120803174016.GE10335@n2100.arm.linux.org.uk>
References: <1344009354-13249-1-git-send-email-marex@denx.de>
 <CAOMZO5AzaDcxJJV+Z-bHH58=xRq5RY6BanEjMd4uUhN+K9ZNZQ@mail.gmail.com>
 <20120803174016.GE10335@n2100.arm.linux.org.uk>
Message-ID: <201208032046.28211.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Russell King - ARM Linux,

[...]

> > > No need to set it to 32768.
> > > 
> > > If you just remove the 'CONFIG_DEFAULT_MMAP_MIN_ADDR=65536' then this
> > > symbol will be 32768.
> > 
> > Sorry, ignore what I said. I just realized that the default is 4096.
> 
> 4096 is also fine for ARM too.  There's not much point in having
> defconfigs change it - that would just be pure noise in the config
> files.

Wasn't there a security concern being the reason for setting this higher? Also, 
I still don't completely understand why ARM has to set it lower than others, is 
that an ABI thing?

Russell, do you happen to have some further reading for me I could study on this 
topic please?

Thanks!

Best regards,
Marek Vasut
