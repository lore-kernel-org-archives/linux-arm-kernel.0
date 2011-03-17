From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 17 Mar 2011 13:21:16 -0600
Subject: [PATCH V11 2/4] ptp: Added a clock that uses the eTSEC found on
	the MPC85xx.
In-Reply-To: <20110225075320.GA4032@riccoc20.at.omicron.at>
References: <cover.1298447722.git.richard.cochran@omicron.at>
	<be1f5e801e8cd0145dd23aadae7c2055bb3c1d47.1298447722.git.richard.cochran@omicron.at>
	<20110223165058.GE14597@angua.secretlab.ca>
	<20110223112612.30071995@schlenkerla>
	<20110223175459.GH14597@angua.secretlab.ca>
	<20110223132444.65dfdda4@schlenkerla>
	<20110224165004.GB15234@riccoc20.at.omicron.at>
	<20110224112731.2d9bf080@schlenkerla>
	<20110225075320.GA4032@riccoc20.at.omicron.at>
Message-ID: <20110317192116.GC12824@angua.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 25, 2011 at 08:53:20AM +0100, Richard Cochran wrote:
> On Thu, Feb 24, 2011 at 11:27:31AM -0600, Scott Wood wrote:
> 
> > My vote, if it goes in a separate node at all, is "fsl,etsec-ptp",
> 
> So, that is what the patch does.
> 
> > and let the driver use SVR.
> 
> What is SVR?

An on chip register that provides the exact version of the SoC.  (As
opposed to PVR which is the version of the cpu core).

g.
