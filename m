From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 12 Nov 2013 19:09:18 -0700
Subject: [PATCH 04/24] mm/block: remove unnecessary inclusion of bootmem.h
In-Reply-To: <1383954120-24368-5-git-send-email-santosh.shilimkar@ti.com>
References: <1383954120-24368-1-git-send-email-santosh.shilimkar@ti.com>
 <1383954120-24368-5-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20131113020918.GA25143@kernel.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 08 2013, Santosh Shilimkar wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> Clean-up to remove depedency with bootmem headers.

Thanks, cleaned up for after merge window inclusion. Changed the wording
to make it more correct and fixed the spelling error:

block: cleanup removing dependency on bootmem headers

-- 
Jens Axboe
