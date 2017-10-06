From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 6 Oct 2017 15:21:12 -0700
Subject: [GIT PULL 2/2] bcm2835-dt-next-2017-10-06
In-Reply-To: <20171006220504.7776-2-eric@anholt.net>
References: <20171006220504.7776-1-eric@anholt.net>
 <20171006220504.7776-2-eric@anholt.net>
Message-ID: <73f132f0-3b98-81e7-1704-810e3947e19e@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/06/2017 03:05 PM, Eric Anholt wrote:
> Hi Florian,
> 
> This -next PR builds on the previous one for -fixes, to get bluetooth
> working by default without userspace hacks.
> 
> The following changes since commit f08f58a2bf68900a84e782b8c7ad701c0654173c:
> 
>   ARM: dts: bcm283x: Fix console path on RPi3 (2017-10-06 13:04:56 -0700)
> 
> are available in the git repository at:
> 
>   git://github.com/anholt/linux tags/bcm2835-dt-next-2017-10-06
> 
> for you to fetch changes up to fd3372db18d3d44ae4579243a8eacb5247d8c03a:
> 
>   ARM: dts: bcm2837-rpi-3-b: Add bcm43438 serial slave (2017-10-06 13:07:21 -0700)
> 
> ----------------------------------------------------------------
> This pull request adds the Pi 3's built in bluetooth device so that it
> can be probed automatically without userspace hciattach calls.
> 
> ----------------------------------------------------------------

Merged both into devicetree/next, thanks!
-- 
Florian
