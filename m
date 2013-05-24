From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 24 May 2013 12:23:46 +0100
Subject: [PATCH 09/11] ARM64: mm: HugeTLB support.
In-Reply-To: <1369328878-11706-10-git-send-email-steve.capper@linaro.org>
References: <1369328878-11706-1-git-send-email-steve.capper@linaro.org>
 <1369328878-11706-10-git-send-email-steve.capper@linaro.org>
Message-ID: <20130524112346.GK18272@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 06:07:56PM +0100, Steve Capper wrote:
> Add huge page support to ARM64, different huge page sizes are
> supported depending on the size of normal pages:
> 
> PAGE_SIZE is 4KB:
>    2MB - (pmds) these can be allocated at any time.
> 1024MB - (puds) usually allocated on bootup with the command line
>          with something like: hugepagesz=1G hugepages=6
> 
> PAGE_SIZE is 64KB:
>  512MB - (pmds) usually allocated on bootup via command line.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
