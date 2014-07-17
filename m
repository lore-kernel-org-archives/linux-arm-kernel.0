From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 17 Jul 2014 13:03:51 +0100
Subject: [PATCH v3 2/3] ARM: Use include/asm-generic/io.h
In-Reply-To: <1405508484-18303-2-git-send-email-thierry.reding@gmail.com>
References: <1405508484-18303-1-git-send-email-thierry.reding@gmail.com>
 <1405508484-18303-2-git-send-email-thierry.reding@gmail.com>
Message-ID: <20140717120351.GH18203@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16, 2014 at 12:01:23PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Include the generic I/O header file so that duplicate implementations
> can be removed. This will also help to establish consistency across more
> architectures regarding which accessors they support.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
