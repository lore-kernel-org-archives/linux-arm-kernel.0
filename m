From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 1 Dec 2011 11:10:50 +0000
Subject: [PATCH v3 4/5] ARM: vexpress: Initial RS1 memory map support
In-Reply-To: <alpine.LFD.2.02.1111301604230.2357@xanadu.home>
References: <1322579473-8804-1-git-send-email-pawel.moll@arm.com>
 <1322579473-8804-5-git-send-email-pawel.moll@arm.com>
 <20111130153749.GE2045@localhost.localdomain>
 <1322673302.3180.25.camel@hornet.cambridge.arm.com>
 <20111130175410.GJ2045@localhost.localdomain>
 <alpine.LFD.2.02.1111301522340.2357@xanadu.home>
 <20111130204805.GA5698@sirena.org.uk>
 <alpine.LFD.2.02.1111301604230.2357@xanadu.home>
Message-ID: <20111201111049.GB2915@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 30, 2011 at 04:38:26PM -0500, Nicolas Pitre wrote:
> On Wed, 30 Nov 2011, Mark Brown wrote:

> > Oh, dear.  Any pointers to the discussions on the u-boot side?

> Certainly.  Many different threads actually.  Here's a few:

OK, thanks - I see Stephen just followed up and Wolfgang seems
moderately happy so hopefully there will be some progress.  It also
occurs to me that there's at least Qi also using uImages, hopefully
other bootloaders are going to be easier to deal with (or already cope).
