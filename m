From: heikki.krogerus@linux.intel.com (Heikki Krogerus)
Date: Thu, 21 Mar 2013 10:47:07 +0200
Subject: [PATCH] serial: 8250_dw: add support for clk api
In-Reply-To: <1363690369-8067-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1363689316-7847-2-git-send-email-maxime.ripard@free-electrons.com>
 <1363690369-8067-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20130321084707.GB2862@xps8300>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 19, 2013 at 11:52:49AM +0100, Maxime Ripard wrote:
> From: Emilio L?pez <emilio@elopez.com.ar>
> 
> This commit implements support for using the clk api; this lets us use
> the "clocks" property with device tree, instead of having to use
> clock-frequency.
> 
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>

FWIW,

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

-- 
heikki
