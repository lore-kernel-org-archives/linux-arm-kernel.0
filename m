From: will.deacon@arm.com (Will Deacon)
Date: Fri, 14 Sep 2018 14:00:39 +0100
Subject: [PATCH] arm64: Remove unused VGA console support
In-Reply-To: <1536839800-14918-1-git-send-email-andrew.murray@arm.com>
References: <1536839800-14918-1-git-send-email-andrew.murray@arm.com>
Message-ID: <20180914130039.GB4010@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2018 at 12:56:40PM +0100, Andrew Murray wrote:
> Support for VGA_CONSOLE is not allowable due to commit ee23794b8668
> ("video: vgacon: Don't build on arm64"), thus remove the associated
> unused code.
> 
> Whilst PCI on arm64 would support VGA a valid screen_info structure
> is missing.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> ---
>  arch/arm64/kernel/setup.c | 4 ----
>  1 file changed, 4 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Will
