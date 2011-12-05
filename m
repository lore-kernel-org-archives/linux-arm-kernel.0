From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Mon, 5 Dec 2011 01:15:18 +0100
Subject: [PATCH 1/3] PM: Provide an always on power domain governor
In-Reply-To: <20111204231005.GA4255@opensource.wolfsonmicro.com>
References: <1322765339-29879-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <201112042156.59990.rjw@sisk.pl>
 <20111204231005.GA4255@opensource.wolfsonmicro.com>
Message-ID: <201112050115.18489.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, December 05, 2011, Mark Brown wrote:
> On Sun, Dec 04, 2011 at 09:56:59PM +0100, Rafael J. Wysocki wrote:
> > On Thursday, December 01, 2011, Mark Brown wrote:
> 
> > > Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> > Looks good with the new version of [2/3].
> 
> > Do you want me to takt it?
> 
> It might make sense for it to go via the Samsung tree - the third patch
> depends on it and there's some other stuff going on with the s3c64xx
> power management - so let's see what Kukjin thinks is best.

OTOH, it will conflict with some patches I have in the works.
