From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 24 May 2013 17:21:10 +0100
Subject: [PATCH] ARM: document the bigger pagetables needed for LPAE
In-Reply-To: <1369410236-22398-1-git-send-email-javi.merino@arm.com>
References: <1369410236-22398-1-git-send-email-javi.merino@arm.com>
Message-ID: <20130524162109.GA22600@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 24, 2013 at 04:43:56PM +0100, Javi Merino wrote:
> The Booting documentation assumes that the initial pagetables are
> 16KiB but since 1b6ba46 (ARM: LPAE: MMU setup for the 3-level page
> table format) they are 20KiB for LPAE kernels.  Thus, the
> recommendation to put atags or the dtb in the first 16KiB is wrong,
> there's only 12KiB of space there in LPAE kernels, so update the
> documentation accordingly.
> ---
>  Documentation/arm/Booting |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Missing Signed-off-by?

-- 
Catalin
