From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 22 May 2013 17:52:23 +0200
Subject: [PATCH v4 4/5] clk: add CLK_SET_RATE_NO_REPARENT flag
In-Reply-To: <1369056507-32521-5-git-send-email-james.hogan@imgtec.com>
References: <1369056507-32521-1-git-send-email-james.hogan@imgtec.com>
 <1369056507-32521-5-git-send-email-james.hogan@imgtec.com>
Message-ID: <20130522155223.GC8595@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On Mon, May 20, 2013 at 02:28:26PM +0100, James Hogan wrote:
> Add a CLK_SET_RATE_NO_REPARENT clock flag, which will prevent muxes
> being reparented during clk_set_rate.
> 
> To avoid breaking existing platforms, all callers of clk_register_mux()
> are adjusted to pass the new flag. Platform maintainers are encouraged
> to remove the flag if they wish to allow mux reparenting on set_rate.

For the sunxi part,
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
