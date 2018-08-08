From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 8 Aug 2018 22:40:17 +0200
Subject: [PATCH v2 1/3] i2c: mediatek: Register i2c adapter driver earlier
In-Reply-To: <1530955795-17714-2-git-send-email-jun.gao@mediatek.com>
References: <1530955795-17714-1-git-send-email-jun.gao@mediatek.com>
 <1530955795-17714-2-git-send-email-jun.gao@mediatek.com>
Message-ID: <20180808204017.yfne5q26lmeegyrr@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 07, 2018 at 05:29:53PM +0800, Jun Gao wrote:
> From: Jun Gao <jun.gao@mediatek.com>
> 
> As i2c adapter, i2c slave devices will depend on it. In order not to
> block the initializations of i2c slave devices, register i2c adapter
> driver at appropriate time.
> 
> Signed-off-by: Jun Gao <jun.gao@mediatek.com>

We don't do this anymore. Check these threads:

http://patchwork.ozlabs.org/project/linux-i2c/list/?series=&submitter=&state=*&q=initcall&archive=&delegate=

(/me just realized that patchwork makes it super easy to point people to
various discussions. Awesome!)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180808/befb8524/attachment.sig>
