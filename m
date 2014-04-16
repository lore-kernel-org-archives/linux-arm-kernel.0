From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 16 Apr 2014 12:52:12 -0300
Subject: [PATCH 1/2] ARM: mvebu: Enable nfsroot in the defconfig
In-Reply-To: <1396539014-8673-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1396539014-8673-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20140416155212.GB1892@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello guys,

On Apr 03, Ezequiel Garcia wrote:
> NFSroot is very frequently used by developers to boot, so let's make
> our lives simpler and enable it by default.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/configs/mvebu_v7_defconfig | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Any comments about this two defconfig changes?

After the recent systemd debug mess, now I'm not sure we should add a defconfig,
just because systemd breaks without it.

Maybe we can merge this one and drop the second one?
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
