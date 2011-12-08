From: olof@lixom.net (Olof Johansson)
Date: Wed, 7 Dec 2011 16:19:41 -0800
Subject: [PATCH 1/5] arm/dt: tegra: Remove /memreserve/ from device-tree
 files
In-Reply-To: <1321911851-10091-1-git-send-email-swarren@nvidia.com>
References: <1321911851-10091-1-git-send-email-swarren@nvidia.com>
Message-ID: <20111208001941.GG12945@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2011 at 02:44:07PM -0700, Stephen Warren wrote:
> There are no drivers in the kernel at present which can make use of the
> memory reserved by /memreserve/, so there is no point reserving it. Remove
> /memreserve/ to allow the user more memory. It's also unclear whether any
> future driver would actually require /memreserve/, or allocate memory
> through some other mechanism.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Thanks, applied to for-3.3/boards


-Olof
