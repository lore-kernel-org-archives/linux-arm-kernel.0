From: horms@verge.net.au (Simon Horman)
Date: Wed, 27 Mar 2013 21:11:05 +0900
Subject: [PATCH] ARM: shmobile: r8a73a4: add thermal driver support
In-Reply-To: <87li9ait0c.wl%kuninori.morimoto.gx@renesas.com>
References: <20130326013414.11796.9937.sendpatchset@w520>
 <87mwtqit29.wl%kuninori.morimoto.gx@renesas.com>
 <87li9ait0c.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <20130327121103.GB15520@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 25, 2013 at 11:18:15PM -0700, Kuninori Morimoto wrote:
> You can get current thermal by
> > cat /sys/class/thermal/thermal_zone?/temp
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/boot/dts/r8a73a4.dtsi         |    7 +++++++
>  arch/arm/mach-shmobile/clock-r8a73a4.c |   13 ++++++++++++-
>  arch/arm/mach-shmobile/setup-r8a73a4.c |   15 +++++++++++++++
>  3 files changed, 34 insertions(+), 1 deletion(-)

Queued up for v3.10 in the soc branch.
