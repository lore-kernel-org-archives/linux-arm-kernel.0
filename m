From: eduardo.valentin@nokia.com (Eduardo Valentin)
Date: Mon, 10 May 2010 15:13:05 +0300
Subject: [PATCHv4 3/4] mach-omap1: export omap1 info under /proc/socinfo
In-Reply-To: <20100510105200.GA14337@n2100.arm.linux.org.uk>
References: <1273487857-32281-1-git-send-email-eduardo.valentin@nokia.com>
	<1273487857-32281-4-git-send-email-eduardo.valentin@nokia.com>
	<20100510105200.GA14337@n2100.arm.linux.org.uk>
Message-ID: <20100510121305.GB8441@besouro.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 10, 2010 at 12:52:00PM +0200, Russell King wrote:
> On Mon, May 10, 2010 at 01:37:36PM +0300, Eduardo Valentin wrote:
> > From: Eduardo Valentin <eduardo.valentin@nokia.com>
> > 
> > Report OMAP name and rev under /proc/socinfo node.
> 
> I think this needs to be combined with the previous patch.  The previous
> patch enables the socinfo file, which means with patch 2 applied but not
> patch 3, OMAP1 breaks.

yes, indeed. I will squash both.

Tks,

--
Eduardo Valentin
