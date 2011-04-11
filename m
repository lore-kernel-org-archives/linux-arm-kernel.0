From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 11 Apr 2011 04:45:59 +0200
Subject: [PATCH] fix build warnings on defconfigs
In-Reply-To: <1302375858-11253-1-git-send-email-wanlong.gao@gmail.com>
References: <1302375858-11253-1-git-send-email-wanlong.gao@gmail.com>
Message-ID: <20110411024559.GB18925@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03:04 Sun 10 Apr     , wanlong.gao at gmail.com wrote:
> From: Wanlong Gao <wanlong.gao@gmail.com>
> 
> Change the BT_L2CAP and BT_SCO defconfigs from 'm' to 'y',
> since BT_L2CAP and BT_SCO had changed to bool configs.
> 
> Signed-off-by: Wanlong Gao <wanlong.gao@gmail.com>
> ---
for at91
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
