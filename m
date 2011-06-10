From: toddpoynor@google.com (Todd Poynor)
Date: Thu, 9 Jun 2011 17:07:15 -0700
Subject: [PATCH 1/8] OMAP2+: clockdomain: Add an api to read idle mode
In-Reply-To: <1307616853-28395-2-git-send-email-rnayak@ti.com>
References: <1307616853-28395-1-git-send-email-rnayak@ti.com>
	<1307616853-28395-2-git-send-email-rnayak@ti.com>
Message-ID: <20110610000715.GA9059@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 09, 2011 at 04:24:06PM +0530, Rajendra Nayak wrote:
> Add a clockdomain api to check if hardware supervised
> idle transitions are enabled on a clockdomain.
> 
...
> + * clkdm_is_idle - Check if the clkdm hwsup/autoidle is enabled

A minor suggestion on naming: "clkdm_allows_idle" seems more accurate
and a natural complement to the existing clkdm_allow_idle().


Todd
