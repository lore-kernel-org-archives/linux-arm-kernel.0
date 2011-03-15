From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 15 Mar 2011 13:36:51 +0100
Subject: [PATCHv2 4/9] macb: convert printk to netdev_ and friends
In-Reply-To: <1300184096-13937-5-git-send-email-jamie@jamieiles.com>
References: <1300184096-13937-1-git-send-email-jamie@jamieiles.com>
	<1300184096-13937-5-git-send-email-jamie@jamieiles.com>
Message-ID: <20110315123651.GF14548@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:14 Tue 15 Mar     , Jamie Iles wrote:
> macb is already using the dev_dbg() and friends helpers so use netdev_()
> along with a pr_fmt() definition to make the printing a little cleaner.
> 
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>
looks fine

Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
