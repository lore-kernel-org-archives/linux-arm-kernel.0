From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 5 Apr 2012 17:37:53 -0600 (MDT)
Subject: [PATCH] ARM: OMAP2+: PRM: fix compile for OMAP4-only build
In-Reply-To: <20120405225345.GJ3785@atomide.com>
References: <1333660837-23249-1-git-send-email-khilman@ti.com>
 <alpine.DEB.2.00.1204051533110.10302@utopia.booyaka.com>
 <20120405225345.GJ3785@atomide.com>
Message-ID: <alpine.DEB.2.00.1204051734560.10302@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 5 Apr 2012, Tony Lindgren wrote:

> I heard of this first from Kevin before I started hitting it with
> my compiles..

Okay.

> Anyways, can you also check that we don't have a similar issue
> with omap44xx_prm_reconfigure_io_chain for omap3 only builds?

Will do.  Clearly I need to be running the full build-test suite on all of 
my branches, as I was doing before the arm-soc transition.

Future pull requests from me will be test-built with a large variety of 
kernel .configs, and will contain a 'size' report for each generated 
binary in the pull request.


- Paul
