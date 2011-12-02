From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 2 Dec 2011 00:33:34 +0000
Subject: [PATCH 2/3] ARM: mach-shmobile: Use common always on power
 domain governor
In-Reply-To: <201112012137.08119.rjw@sisk.pl>
References: <1322765339-29879-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1322765339-29879-2-git-send-email-broonie@opensource.wolfsonmicro.com>
 <201112012137.08119.rjw@sisk.pl>
Message-ID: <20111202003333.GC31903@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2011 at 09:37:07PM +0100, Rafael J. Wysocki wrote:
> On Thursday, December 01, 2011, Mark Brown wrote:
> > Saves a tiny amount of code.

> How so?

It saves source code size when we get the second user, by itself you're
right it doesn't achieve anything (except avoiding redundancy once 1/3
gets applied I guess).
