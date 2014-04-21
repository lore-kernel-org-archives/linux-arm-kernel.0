From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 21 Apr 2014 20:30:37 +0200
Subject: [PATCH 0/5] fixing regressions caused by Dove in MULTI_V7
In-Reply-To: <1397585763-23482-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <20140414151236.75f8816d@skate>
 <1397585763-23482-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20140421203037.6ab02445@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian, Russell,

On Tue, 15 Apr 2014 20:15:58 +0200, Sebastian Hesselbarth wrote:
> This is a patch set fixing regressions in v3.15-rc1 ultimately caused
> by adding DT-enabled Marvell Dove to MULTI_V7. There was a fix
> introduced late in the merge window to fix a related regression for
> non-PJ4 architectures, that turned out to introduce another regression
> on PJ4B-based Armada 370/XP.

[...]

> Russell, please let me know if/when you are happy with the fixes
> and the improvement. I'll be adding them to your patch tracker then.

Any plans towards merging those patches, or at least PATCH 1 to 4 ?
They fix a regression on 3.15-r1 affecting mvebu platforms, and it
would be good to have that fixed by 3.15 final.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
