From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 28 Oct 2016 15:29:06 +0530
Subject: [PATCH v7 0/4] da8xx USB PHY platform devices and clocks
In-Reply-To: <1477527498-21930-1-git-send-email-david@lechnology.com>
References: <1477527498-21930-1-git-send-email-david@lechnology.com>
Message-ID: <c579032c-43ee-803f-9433-c0684527f53f@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 October 2016 05:48 AM, David Lechner wrote:
> This series depends on [v3] ARM: davinci: da8xx: Fix some redefined symbol
> warnings <https://patchwork.kernel.org/patch/9397005/> being applied first.
> 
> v7 changes:
> * Dropped patches that have been accepted into linux-davinci already
> * New patch for adding device names to clock lookup tables
> * Picked up related patch from Axel Haslam for registering USB PHY clocks on
>   device tree boards and added error checking to to that patch
> * Rebased on latest linux-davinci + linux-next
> * Added devices instead of NULL in clk_get() where appropriate usb-da8xx.c
> * Re-ordered patches so that they apply/build cleanly

The series looks good to me now. Since this is considerable change from
previous version, I will wait a while to see if others have any comments
before applying this.

Thanks,
Sekhar
