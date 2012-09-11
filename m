From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 11 Sep 2012 20:09:48 +0000 (UTC)
Subject: [PATCH 00/29] Move OMAP2+ over to use COMMON clock
In-Reply-To: <alpine.DEB.2.00.1209110403130.23042@utopia.booyaka.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1209110403130.23042@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1209112005080.9444@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Sep 2012, Paul Walmsley wrote:

> The branch was then built with a set of testing Kconfigs.  Here's what was 
> found: (these are still being investigated)
> 
> - The OMAP4-only testconfig and rmk's OMAP4430-SDP Kconfigs failed:
>   "undefined reference to `omap2_clkt_iclk_allow_idle'":
> 
>   http://www.pwsan.com/omap/testlogs/common_clk_testing_devel_3.7/20120911000742/build/omap4_testconfig/
>   http://www.pwsan.com/omap/testlogs/common_clk_testing_devel_3.7/20120911000742/build/rmk_omap4430_sdp_oldconfig/
> 
> - RMK's OMAP3430-LDP Kconfig failed with a whole set of warnings:
> 
>   http://www.pwsan.com/omap/testlogs/common_clk_testing_devel_3.7/20120911000742/build/rmk_omap3430_ldp_oldconfig/

These build problems have been fixed and the branch updated.  Current test 
logs at

http://www.pwsan.com/omap/testlogs/common_clk_testing_devel_3.7/20120911134655/


- Paul
