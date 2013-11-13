From: horms@verge.net.au (Simon Horman)
Date: Wed, 13 Nov 2013 12:30:29 +0900
Subject: [PATCH] ARM: shmobile: kzm9d: Enable AUTO_ZRELADDR in defconfig
In-Reply-To: <1383954465-6056-1-git-send-email-horms+renesas@verge.net.au>
References: <1383954465-6056-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20131113033029.GF22484@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 09, 2013 at 08:47:45AM +0900, Simon Horman wrote:
> This is required to allow the load address to be supplied
> as an environment variable when building a uImage.
> 
> LOADADDR=0x40008000 ARCH=arm make uImage
> 
> This is necessary since "ARM: shmobile: Remove legacy KZM9D board code"
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

I have queued this up.
