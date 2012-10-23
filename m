From: will.deacon@arm.com (Will Deacon)
Date: Tue, 23 Oct 2012 15:57:37 +0100
Subject: ERROR: "read_current_timer" [fs/ext4/ext4.ko] undefined
In-Reply-To: <022101cdb12d$724e9650$56ebc2f0$@org>
References: <022101cdb12d$724e9650$56ebc2f0$@org>
Message-ID: <20121023145737.GB2823@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2012 at 03:48:21PM +0100, Kukjin Kim wrote:
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

A fix for this is queued in rmk's fixes branch.

Will
