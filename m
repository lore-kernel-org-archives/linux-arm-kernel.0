From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 11 Mar 2011 13:53:38 +0100
Subject: [PATCH 3/8] macb: convert printk to pr_ and friends
In-Reply-To: <1299751843-9743-4-git-send-email-jamie@jamieiles.com>
References: <1299751843-9743-1-git-send-email-jamie@jamieiles.com>
	<1299751843-9743-4-git-send-email-jamie@jamieiles.com>
Message-ID: <20110311125338.GM9351@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:10 Thu 10 Mar     , Jamie Iles wrote:
> macb is already using the dev_dbg() and friends helpers so use pr_foo()
> along with a pr_fmt() definition to make the printing a little cleaner.
> 
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
