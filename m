From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 20 Dec 2013 12:05:35 +0000
Subject: [PATCH v2 1/5] arm64: Remove unused __data_loc variable
In-Reply-To: <1386980413.1002.94.camel@smoke>
References: <cover.1386879684.git.geoff@infradead.org>
 <1386980413.1002.94.camel@smoke>
Message-ID: <20131220120535.GI25477@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 14, 2013 at 12:20:13AM +0000, Geoff Levand wrote:
> The __data_loc variable is an unused left over from the 32 bit arm implementation.
> Remove that variable and adjust the __mmap_switched startup routine accordingly.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org> for Huawei, Linaro

Applied. Thanks.

-- 
Catalin
