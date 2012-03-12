From: rnayak@ti.com (Rajendra Nayak)
Date: Mon, 12 Mar 2012 11:23:41 +0530
Subject: [PATCHv5 0/6] ARM: OMAP3+: IO daisy chain support fixes
In-Reply-To: <alpine.DEB.2.00.1203092102450.30879@utopia.booyaka.com>
References: <1331046702-2472-1-git-send-email-t-kristo@ti.com>
 <alpine.DEB.2.00.1203092102450.30879@utopia.booyaka.com>
Message-ID: <4F5D8F65.7000205@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 10 March 2012 09:35 AM, Paul Walmsley wrote:
> The main outstanding question is whether the OMAP4 WUCLKOUT poll should be
> removed to match the v5 changes to the OMAP3 function.  Please let me
> know.   Any other testing or comments are of course welcome.

I think we should instead add it back in omap3 and keep the omap4 as is.
