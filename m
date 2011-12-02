From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Fri, 2 Dec 2011 23:36:19 +0100
Subject: [PATCH 2/3] ARM: mach-shmobile: Use common always on power domain
 governor
In-Reply-To: <20111202003333.GC31903@opensource.wolfsonmicro.com>
References: <1322765339-29879-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <201112012137.08119.rjw@sisk.pl>
 <20111202003333.GC31903@opensource.wolfsonmicro.com>
Message-ID: <201112022336.19993.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, December 02, 2011, Mark Brown wrote:
> On Thu, Dec 01, 2011 at 09:37:07PM +0100, Rafael J. Wysocki wrote:
> > On Thursday, December 01, 2011, Mark Brown wrote:
> > > Saves a tiny amount of code.
> 
> > How so?
> 
> It saves source code size when we get the second user, by itself you're
> right it doesn't achieve anything (except avoiding redundancy once 1/3
> gets applied I guess).

But the patch removed useful code without adding any replacements, as far
as I could see it.

Thanks,
Rafael
