From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 4 Dec 2013 09:57:40 -0500
Subject: [PATCH v2 06/23] mm/char: remove unnecessary inclusion of
 bootmem.h
In-Reply-To: <20131203225513.GV8277@htj.dyndns.org>
References: <1386037658-3161-1-git-send-email-santosh.shilimkar@ti.com>
 <1386037658-3161-7-git-send-email-santosh.shilimkar@ti.com>
 <20131203225513.GV8277@htj.dyndns.org>
Message-ID: <529F42E4.8080703@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 December 2013 05:55 PM, Tejun Heo wrote:
> On Mon, Dec 02, 2013 at 09:27:21PM -0500, Santosh Shilimkar wrote:
>> From: Grygorii Strashko <grygorii.strashko@ti.com>
>>
>> Clean-up to remove depedency with bootmem headers.
>>
>> Cc: Yinghai Lu <yinghai@kernel.org>
>> Cc: Tejun Heo <tj@kernel.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> Please merge 4-6 into a single patch.
> 
Will do
