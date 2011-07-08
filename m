From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 8 Jul 2011 17:36:06 +0800
Subject: [PATCH v2 1/5] dt: add of_alias_scan and of_alias_get_id
In-Reply-To: <1308938676-31121-2-git-send-email-shawn.guo@linaro.org>
References: <1308938676-31121-1-git-send-email-shawn.guo@linaro.org>
	<1308938676-31121-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110708093605.GE12722@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

I saw neither your comments nor ack on this patch.  Where does it go?

Regards,
Shawn

On Sat, Jun 25, 2011 at 02:04:32AM +0800, Shawn Guo wrote:
> The patch adds function of_alias_scan to populate a global lookup
> table with the properties of 'aliases' node and function
> of_alias_get_id for drivers to find alias id from the lookup table.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> ---
