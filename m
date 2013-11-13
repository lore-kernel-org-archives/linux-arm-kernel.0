From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 13 Nov 2013 18:10:19 -0500
Subject: [PATCH 04/24] mm/block: remove unnecessary inclusion of bootmem.h
In-Reply-To: <20131113020918.GA25143@kernel.dk>
References: <1383954120-24368-1-git-send-email-santosh.shilimkar@ti.com>
 <1383954120-24368-5-git-send-email-santosh.shilimkar@ti.com>
 <20131113020918.GA25143@kernel.dk>
Message-ID: <528406DB.7070605@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 November 2013 09:09 PM, Jens Axboe wrote:
> On Fri, Nov 08 2013, Santosh Shilimkar wrote:
>> From: Grygorii Strashko <grygorii.strashko@ti.com>
>>
>> Clean-up to remove depedency with bootmem headers.
> 
> Thanks, cleaned up for after merge window inclusion. Changed the wording
> to make it more correct and fixed the spelling error:
> 
> block: cleanup removing dependency on bootmem headers
> 
Thanks !!

regards,
Santosh
