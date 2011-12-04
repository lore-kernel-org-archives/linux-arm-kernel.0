From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 4 Dec 2011 23:10:05 +0000
Subject: [PATCH 1/3] PM: Provide an always on power domain governor
In-Reply-To: <201112042156.59990.rjw@sisk.pl>
References: <1322765339-29879-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <201112042156.59990.rjw@sisk.pl>
Message-ID: <20111204231005.GA4255@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 04, 2011 at 09:56:59PM +0100, Rafael J. Wysocki wrote:
> On Thursday, December 01, 2011, Mark Brown wrote:

> > Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

> Looks good with the new version of [2/3].

> Do you want me to takt it?

It might make sense for it to go via the Samsung tree - the third patch
depends on it and there's some other stuff going on with the s3c64xx
power management - so let's see what Kukjin thinks is best.
