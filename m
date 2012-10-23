From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 23 Oct 2012 15:57:22 +0100
Subject: ERROR: "read_current_timer" [fs/ext4/ext4.ko] undefined
In-Reply-To: <022101cdb12d$724e9650$56ebc2f0$@org>
References: <022101cdb12d$724e9650$56ebc2f0$@org>
Message-ID: <5086B052.3030105@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/10/12 15:48, Kukjin Kim wrote:
> Hi all,
> 
> Now, v3.7-rc2 happens following build error with s3c2410_defconfig...
> 
> ERROR: "read_current_timer" [fs/ext4/ext4.ko] undefined!
> make[2]: *** [__modpost] Error 1
> make[1]: *** [modules] Error 2
> make[1]: *** Waiting for unfinished jobs....
> 
> Any idea on this?

This is becoming a recurring pattern...

Please see:
https://patchwork.kernel.org/patch/1570611/
https://lkml.org/lkml/2012/10/9/393

and probably a few other instances...

	M.
-- 
Jazz is not dead. It just smells funny...
