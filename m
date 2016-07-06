From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 6 Jul 2016 08:33:32 -0700
Subject: [PATCH] clocksource: cadence_ttc: fix a return value in case of
 error
In-Reply-To: <1467783323-16632-1-git-send-email-christophe.jaillet@wanadoo.fr>
References: <1467783323-16632-1-git-send-email-christophe.jaillet@wanadoo.fr>
Message-ID: <20160706153332.GN19175@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-07-06 at 07:35:23 +0200, Christophe JAILLET wrote:
> IS_ERR and PTR_ERR should use the same variable, clk_ce in this case.
> 
> Fixes: 4de1eb07c47f (Convert init function to return error)
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>

	S?ren
