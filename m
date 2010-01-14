From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 14 Jan 2010 09:53:21 +0000
Subject: [PATCH 2.6.33] SMDK6410: Specify no GPIO for B_PWR_5V regulator
In-Reply-To: <20100114004104.GN18532@trinity.fluff.org>
References: <1263391024-29502-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20100114004104.GN18532@trinity.fluff.org>
Message-ID: <20100114095320.GA437@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 14, 2010 at 12:41:04AM +0000, Ben Dooks wrote:
> On Wed, Jan 13, 2010 at 01:57:04PM +0000, Mark Brown wrote:
> > Since the fixed voltage regulator grew support for GPIO based
> > enables and GPIO 0 is valid on some systems we need to specify
> > that there is no valid GPIO enable control.

> should this be posted for -rc?

Yes.
