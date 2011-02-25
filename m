From: richardcochran@gmail.com (Richard Cochran)
Date: Fri, 25 Feb 2011 08:53:20 +0100
Subject: [PATCH V11 2/4] ptp: Added a clock that uses the eTSEC found
	on the MPC85xx.
In-Reply-To: <20110224112731.2d9bf080@schlenkerla>
References: <cover.1298447722.git.richard.cochran@omicron.at>
	<be1f5e801e8cd0145dd23aadae7c2055bb3c1d47.1298447722.git.richard.cochran@omicron.at>
	<20110223165058.GE14597@angua.secretlab.ca>
	<20110223112612.30071995@schlenkerla>
	<20110223175459.GH14597@angua.secretlab.ca>
	<20110223132444.65dfdda4@schlenkerla>
	<20110224165004.GB15234@riccoc20.at.omicron.at>
	<20110224112731.2d9bf080@schlenkerla>
Message-ID: <20110225075320.GA4032@riccoc20.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 24, 2011 at 11:27:31AM -0600, Scott Wood wrote:

> My vote, if it goes in a separate node at all, is "fsl,etsec-ptp",

So, that is what the patch does.

> and let the driver use SVR.

What is SVR?

Thanks,
Richard
