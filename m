From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 3 Dec 2011 11:03:09 +0000
Subject: [PATCH 2/3] ARM: mach-shmobile: Use common always on power
 domain governor
In-Reply-To: <201112022336.19993.rjw@sisk.pl>
References: <1322765339-29879-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <201112012137.08119.rjw@sisk.pl>
 <20111202003333.GC31903@opensource.wolfsonmicro.com>
 <201112022336.19993.rjw@sisk.pl>
Message-ID: <20111203110309.GA6043@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 02, 2011 at 11:36:19PM +0100, Rafael J. Wysocki wrote:
> On Friday, December 02, 2011, Mark Brown wrote:

> > It saves source code size when we get the second user, by itself you're
> > right it doesn't achieve anything (except avoiding redundancy once 1/3
> > gets applied I guess).

> But the patch removed useful code without adding any replacements, as far
> as I could see it.

The first patch in the series added the replacement as generic code,
this patch is deleting the shmobile specific implementation and using
the generic code instead.
