From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 18 Feb 2014 11:38:51 -0500
Subject: [linux-next] Adding keystone kernel tree
In-Reply-To: <20140218104644.60a6f17f957b7034d015932d@canb.auug.org.au>
References: <53028BD5.9010705@ti.com>
 <20140218104644.60a6f17f957b7034d015932d@canb.auug.org.au>
Message-ID: <53038C9B.7010701@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 February 2014 06:46 PM, Stephen Rothwell wrote:
> Hi Santosh,
> 
> On Mon, 17 Feb 2014 17:23:17 -0500 Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
>>
>> I would like to add keystone-linux next to linux-next to take advantage
>> of testing and integration issues. The tree is already officially
>> mentioned in the MAINTAINERS file
>>
>> ARM/TEXAS INSTRUMENT KEYSTONE ARCHITECTURE
>> M:      Santosh Shilimkar <santosh.shilimkar@ti.com>
>> L:      linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>> S:      Maintained
>> F:      arch/arm/mach-keystone/
>> F:      drivers/clk/keystone/
>> T:      git git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git
>>
>> Can you please add 'next' branch from the git tree to linux-next ?
> 
> Added from today.  I assume that it will be merged via the arm-soc tree?
> 
Right. 

> Thanks for adding your subsystem tree as a participant of linux-next.  As
> you may know, this is not a judgment of your code.  The purpose of
> linux-next is for integration testing and to lower the impact of
> conflicts between subsystems in the next merge window. 
> 
> You will need to ensure that the patches/commits in your tree/series have
> been:
>      * submitted under GPL v2 (or later) and include the Contributor's
> 	Signed-off-by,
>      * posted to the relevant mailing list,
>      * reviewed by you (or another maintainer of your subsystem tree),
>      * successfully unit tested, and 
>      * destined for the current or next Linux merge window.
> 
> Basically, this should be just what you would send to Linus (or ask him
> to fetch).  It is allowed to be rebased if you deem it necessary.
> 
Thanks Stephen

Regards,
Santosh
