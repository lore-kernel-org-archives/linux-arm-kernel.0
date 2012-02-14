From: kamezawa.hiroyu@jp.fujitsu.com (KAMEZAWA Hiroyuki)
Date: Tue, 14 Feb 2012 17:31:17 +0900
Subject: [PATCHv21 09/16] mm: page_isolation: MIGRATE_CMA isolation
 functions added
In-Reply-To: <1328895151-5196-10-git-send-email-m.szyprowski@samsung.com>
References: <1328895151-5196-1-git-send-email-m.szyprowski@samsung.com>
 <1328895151-5196-10-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20120214173117.3f0bf523.kamezawa.hiroyu@jp.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 10 Feb 2012 18:32:24 +0100
Marek Szyprowski <m.szyprowski@samsung.com> wrote:

> From: Michal Nazarewicz <mina86@mina86.com>
> 
> This commit changes various functions that change pages and
> pageblocks migrate type between MIGRATE_ISOLATE and
> MIGRATE_MOVABLE in such a way as to allow to work with
> MIGRATE_CMA migrate type.
> 
> Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Rob Clark <rob.clark@linaro.org>
> Tested-by: Ohad Ben-Cohen <ohad@wizery.com>
> Tested-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>

Reviewed-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
