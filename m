From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 8 Jul 2014 08:20:27 -0400
Subject: [PATCH 1/2] ARM: mvebu: add appended DTB support in
 mvebu_v5_defconfig
In-Reply-To: <1404375830-22169-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1404375830-22169-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140708122027.GV23978@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Thu, Jul 03, 2014 at 10:23:49AM +0200, Thomas Petazzoni wrote:
> The mvebu_v5_defconfig is currently used for Kirkwood platforms, and
> in the future hopefully used for Orion5x platforms. Those platforms
> use fairly old bootloaders that don't have Device Tree support, so it
> makes sense to enable appended DTB support by default, as well as the
> backward compatibility with ATAGS passed by the bootloader for those
> platforms. It helps having a defconfig that works fine out of the box
> for most Kirkwood platforms.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/configs/mvebu_v5_defconfig | 2 ++
>  1 file changed, 2 insertions(+)

Both applied to mvebu/defconfig with Andrew's Ack.

thx,

Jason.
