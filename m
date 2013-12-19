From: horms@verge.net.au (Simon Horman)
Date: Thu, 19 Dec 2013 18:06:26 +0900
Subject: [PATCH 0/2] ARM: shmobile: koelsch: defconfig updates
In-Reply-To: <1387154049-9105-1-git-send-email-horms+renesas@verge.net.au>
References: <1387154049-9105-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20131219090626.GE12239@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 16, 2013 at 09:34:07AM +0900, Simon Horman wrote:
> Updates for Koelsch defconfig to allow it to boot
> a Debian armhf userspace and to bring it into line
> with other shmobile defconfigs.
> 
> Based on the renesas-devel-v3.13-rc3-20131214v2 tag
> of my renesas tree.
> 
> Simon Horman (2):
>   ARM: shmobile: koelsch: Enable CONFIG_PACKET in defconfig
>   ARM: shmobile: koelsch: Do not disable CONFIG_{INOTIFY_USER,UNIX} in
>     defconfig
> 
>  arch/arm/configs/koelsch_defconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

I have queued these up.
