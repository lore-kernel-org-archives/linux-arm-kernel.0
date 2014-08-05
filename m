From: airlied@linux.ie (Dave Airlie)
Date: Tue, 5 Aug 2014 05:20:25 +0100 (IST)
Subject: linux-next: build failures after merge of the drm tree
In-Reply-To: <20140805130926.4e8c8fe5@canb.auug.org.au>
References: <20140805130926.4e8c8fe5@canb.auug.org.au>
Message-ID: <alpine.DEB.2.00.1408050519270.22643@skynet.skynet.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Hi Dave,
> 
> After merging the drm tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> ERROR: "drm_sysfs_connector_remove" [drivers/gpu/drm/i2c/tda998x.ko] undefined!
> ERROR: "drm_sysfs_connector_add" [drivers/gpu/drm/i2c/tda998x.ko] undefined!
> 

I've fixed this, caught it myself a few mins after push,

The other I'm not sure about, I'll hope the exynos guys know what is going 
on.

Thanks,
Dave.
