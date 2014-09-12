From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 12 Sep 2014 16:36:10 +0100
Subject: [PATCH] arm64: pageattr: Correctly adjust unaligned start
 addresses
In-Reply-To: <1410473432-13381-1-git-send-email-lauraa@codeaurora.org>
References: <54112831.6010800@codeaurora.org>
 <1410473432-13381-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <20140912153610.GD5532@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 11:10:32PM +0100, Laura Abbott wrote:
> The start address needs to be actually updated after it
> is detected to be unaligned. Adjust it and the end address
> properly.
> 
> Reported-by: Zi Shen Lim <zlim.lnx@gmail.com>
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> ---
>  arch/arm64/mm/pageattr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied. Thanks.

-- 
Catalin
