From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 22 Apr 2018 11:14:43 +0200
Subject: [PATCH 07/61] dma: simplify getting .drvdata
In-Reply-To: <20180422061733.GU6014@localhost>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-8-wsa+renesas@sang-engineering.com>
 <20180422061733.GU6014@localhost>
Message-ID: <20180422091443.ryfdum5nhjc2b7qw@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 22, 2018 at 11:47:33AM +0530, Vinod Koul wrote:
> On Thu, Apr 19, 2018 at 04:05:37PM +0200, Wolfram Sang wrote:
> > We should get drvdata from struct device directly. Going via
> > platform_device is an unneeded step back and forth.
> 
> Do you mind splitting this per driver please, that makes it easy to manage
> for me :)

No problem, done.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180422/210b6631/attachment.sig>
