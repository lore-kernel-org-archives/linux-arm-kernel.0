From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 24 Apr 2014 00:34:05 -0400
Subject: [PATCH 1/2] ARM: mvebu: Enable nfsroot in the defconfig
In-Reply-To: <1396539014-8673-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1396539014-8673-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20140424043405.GS28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 03, 2014 at 12:30:13PM -0300, Ezequiel Garcia wrote:
> NFSroot is very frequently used by developers to boot, so let's make
> our lives simpler and enable it by default.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/configs/mvebu_v7_defconfig | 5 +++++
>  1 file changed, 5 insertions(+)

Both applied to mvebu/defconfig

thx,

Jason.
