From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 20 Nov 2014 18:23:04 +0000 (UTC)
Subject: [PATCH v2 0/3] Add support for ADC on am437x-gp and am43x-epos-evm
In-Reply-To: <20141114185049.GB7046@atomide.com>
References: <1415099728-10959-1-git-send-email-vigneshr@ti.com>
 <54657FFA.1070200@ti.com> <20141114185049.GB7046@atomide.com>
Message-ID: <alpine.DEB.2.02.1411201821300.9204@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 14 Nov 2014, Tony Lindgren wrote:

> * Vignesh R <vigneshr@ti.com> [141113 20:09]:
> > 
> > On Tuesday 04 November 2014 04:45 PM, Vignesh R wrote:
> > > This series of patches enable ADC on am437x-gp-evm and am43x-epos-evm.
> > > The ADC clock hwmod data of am33xx has been moved to commom place so that
> > > both am43xx and am33xx can reuse them.
> > > tscadc DT node has been adided to am437x-gp and am43x-epos dt files.
> > > With these patches, ADC functionalities are now available on am43xx.
> > > 
> > > Changelog:
> > > 
> > > v2:
> > > Removed phy addresses in hwmod. Using DT instead.
> > > Removed unused "ti,am4372" compatible string.
> > > Use macro to set clk domain name.
> > > Fixed subject format of all patches
> > > 
> > 
> > Please accept these patches.
> 
> Adding Paul to Cc, I don't think Paul has seen these, probably because
> get_maintainer.pl did not catch these hwmod files?

Yeah we didn't have top-level coverage for the data files and my 
attempts to find other in-depth reviewers has so far failed.  So just sent 
this:

http://marc.info/?l=linux-omap&m=141650684712440&w=2

Want to take it upstream?


- Paul
