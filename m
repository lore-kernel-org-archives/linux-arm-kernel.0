From: olof@lixom.net (Olof Johansson)
Date: Thu, 1 Jun 2017 17:19:02 -0700
Subject: [PATCH 0/2] ARCH_VULCAN removal
In-Reply-To: <1495438565-82495-1-git-send-email-jnair@caviumnetworks.com>
References: <1495438565-82495-1-git-send-email-jnair@caviumnetworks.com>
Message-ID: <20170602001902.GJ13314@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 22, 2017 at 07:36:03AM +0000, Jayachandran C wrote:
> Another couple of patches to remove more of ARCH_VULCAN platform.
> 
> There is still a reference in drivers/gpio/Kconfig for ARCH_VULCAN.
> I am sending a patch to remove that, and after that we can completely
> remove ARCH_VULCAN.
> 

Applied to next/arm64 for v4.13.

-Olof
