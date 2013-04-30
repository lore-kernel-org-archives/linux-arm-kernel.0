From: horms@verge.net.au (Simon Horman)
Date: Tue, 30 Apr 2013 11:10:04 +0900
Subject: [PATCH] ARM: shmobile: lager: Add GPIO LEDs
In-Reply-To: <1366684625-17256-1-git-send-email-horms+renesas@verge.net.au>
References: <1366684625-17256-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20130430021002.GA5547@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 23, 2013 at 11:37:05AM +0900, Simon Horman wrote:
> The board has 3 LEDs connected to GPIOs. Add a led-gpio device to
> support them.
> 
> Based on "ARM: shmobile: marzen: Add GPIO LEDs" by Laurent Pinchart.
> 
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> ---
> 
> v2
> * As suggested by Sergei Shtylyov:
>   Use platform_device_register_data() instead of platform_add_devices()
> * As suggested by Laurent Pinchart:
>   Use -1 as device id as there is only one such device
> ---
>  arch/arm/mach-shmobile/board-lager.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)

I have queued-up this patch for v3.11 in the boards-lager branch.
