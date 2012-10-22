From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 21 Oct 2012 23:07:48 -0400
Subject: [PATCH 2/2] ARM: kirkwood: use gpio-fan DT binding on lsxl
In-Reply-To: <1350776094-16778-2-git-send-email-michael@walle.cc>
References: <1350776094-16778-1-git-send-email-michael@walle.cc>
 <1350776094-16778-2-git-send-email-michael@walle.cc>
Message-ID: <20121022030748.GI25828@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 21, 2012 at 01:34:54AM +0200, Michael Walle wrote:
> Remove board specific gpio-fan driver registration. Moved into device tree.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  arch/arm/boot/dts/kirkwood-lsxl.dtsi |   11 ++++++++
>  arch/arm/mach-kirkwood/board-lsxl.c  |   47 ----------------------------------
>  2 files changed, 11 insertions(+), 47 deletions(-)

Applied to:

git://git.infradead.org/users/jcooper/linux.git kirkwood/boards

thx,

Jason.
