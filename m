From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 18 Mar 2016 10:22:03 +0000
Subject: [PATCH] MAINTAINERS: attach arch/arm/configs/mvebu_*_defconfig
 to relevant maintainers
In-Reply-To: <1458289626-26153-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1458289626-26153-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20160318102203.GJ1184@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 18, 2016 at 09:27:06AM +0100, Thomas Petazzoni wrote:
> The arch/arm/configs/mvebu_*_defconfig currently don't belong to any
> maintainer, so get_maintainer returns only information based on
> commits, which is not completely accurate.
> 
> Therefore, this commit replaces a useless empty newline in MAINTAINERS
> by a line attaching those defconfigs to the appropriate Marvell EBU
> maintainers.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
