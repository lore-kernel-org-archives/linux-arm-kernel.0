From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 18 Jun 2013 16:56:21 +0400
Subject: linux-next: manual merge of the arm-soc tree with the usb tree
In-Reply-To: <20130618161239.5ce92432180d9418831d2514@canb.auug.org.au>
References: <20130618161239.5ce92432180d9418831d2514@canb.auug.org.au>
Message-ID: <51C058F5.80609@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 18-06-2013 10:12, Stephen Rothwell wrote:

> Today's linux-next merge of the arm-soc tree got a conflict in
> drivers/usb/phy/phy-rcar-usb.c between commit 56a9a6de2a87 ("usb: phy:
> rcar-usb: Fix comment w.r.t. devm_ioremap_resource") from the usb tree
> and commit 725bf9dcafe1 ("phy-rcar-usb: correct base address") from the
> arm-soc tree.

    Darn, and I forewarned not to apply the former commit.

WBR, Sergei
