From: tj@kernel.org (Tejun Heo)
Date: Mon, 2 Nov 2015 14:10:44 -0500
Subject: [PATCH v6 1/3] percpu: remove PERCPU_ENOUGH_ROOM which is stale
 definition
In-Reply-To: <1446363977-23656-2-git-send-email-jungseoklee85@gmail.com>
References: <1446363977-23656-1-git-send-email-jungseoklee85@gmail.com>
 <1446363977-23656-2-git-send-email-jungseoklee85@gmail.com>
Message-ID: <20151102191044.GA9553@mtj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 01, 2015 at 07:46:15AM +0000, Jungseok Lee wrote:
> As pure cleanup, this patch removes PERCPU_ENOUGH_ROOM which is not
> used any more. That is, no code refers to the definition.
> 
> Signed-off-by: Jungseok Lee <jungseoklee85@gmail.com>

Applied to percpu/for-4.4.

Thanks.

-- 
tejun
