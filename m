From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Mar 2014 09:28:49 +0100
Subject: please revert: regulator: dbx500: use seq_puts() instead of
 seq_printf()
In-Reply-To: <001001cf4415$902bdf30$b0839d90$%han@samsung.com>
References: <6651295.YIkvtDO9zo@wuerfel>
 <001001cf4415$902bdf30$b0839d90$%han@samsung.com>
Message-ID: <34465260.biJ0eJ2oKB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 March 2014 17:22:41 Jingoo Han wrote:
> On Thursday, March 20, 2014 4:57 PM, Arnd Bergmann wrote:
> > 
> > This patch has shown up in linux-next yesterday, breaking a randconfig
> > build:
> 
> (+cc Fengguang Wu)
> 
> Hi Arnd,
> 
> I really appreciate your report.
> However, it was already reported by Fengguang Wu 2 days ago.
> And, a modified patch was already merged to the current regulator
> next tree. 
> 
> Thus, today's linux-next (20140320) cannot make the problem
> anymore. As presented above, the modified patch was merged
> to today's linux-next. [1]
> 
> I will be more careful next time. Sorry for annoying you.
> Thank you.
> 
> [1] http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=80c48e72f831bbfea4bf58d8e78ff2b18c90ec17)
> 

Ok, very good. Thanks for the reply. I probably should have
rebased on today's linux-next before looking for last night's
build errors.

	Arnd
