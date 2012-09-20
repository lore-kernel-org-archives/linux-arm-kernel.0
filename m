From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 19 Sep 2012 21:26:05 -0400
Subject: [PATCH 02/34] ASoC: mx27vis: retrieve gpio numbers from
 platform_data
In-Reply-To: <20120920011456.GC2450@S2101-09.ap.freescale.net>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
 <1347860103-4141-3-git-send-email-shawn.guo@linaro.org>
 <20120917110741.GD5401@opensource.wolfsonmicro.com>
 <20120920011456.GC2450@S2101-09.ap.freescale.net>
Message-ID: <20120920012605.GD17666@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2012 at 09:14:59AM +0800, Shawn Guo wrote:
> On Mon, Sep 17, 2012 at 07:07:42AM -0400, Mark Brown wrote:

> > I've applied this since Javier says it fixes a bug but I'm not terribly
> > enthused about it.

> Ok.  But now we have a cross-tree dependency.  Please ensure your
> for-3.7 branch is stable, so that I can ask arm-soc folks to pull
> it as dependency of my series.  Or you need to create a topic branch
> for this patch.

What's the dependency here?
