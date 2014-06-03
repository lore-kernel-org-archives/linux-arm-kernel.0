From: yamada.m@jp.panasonic.com (Masahiro Yamada)
Date: Tue, 03 Jun 2014 15:19:16 +0900
Subject: [PATCH] ARM: decompressor: a minor optimization
In-Reply-To: <20140602102516.GC3855@e103592.cambridge.arm.com>
References: <1401449433-1963-1-git-send-email-yamada.m@jp.panasonic.com>
 <20140602102516.GC3855@e103592.cambridge.arm.com>
Message-ID: <20140603151916.3224.AA925319@jp.panasonic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,


> Loading sp with LDMIA is not allowed in Thumb.  For simpler code
> maintenance, the code was just made Thumb-compatible anyway by splitting
> out the sp load while fixing another issue.  This isn't part of a core
> loop, so shouldn't have a significant impact on performance.
> 
> git blame can be useful for finding out how an odd-looking piece of code
> came into existence.  Sometimes you have to dig through a few patches to
> find the answer.


Thank you for explaning this!

Please disregard this patch. Sorry for noise.


Best Regards
Masahiro Yamada
