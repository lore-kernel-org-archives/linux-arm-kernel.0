From: tony@atomide.com (Tony Lindgren)
Date: Mon, 14 Jan 2013 09:22:22 -0800
Subject: linux-next: manual merge of the arm-soc tree with the crypto tree
In-Reply-To: <20130114134908.094003722be0612c20574338@canb.auug.org.au>
References: <20130114134908.094003722be0612c20574338@canb.auug.org.au>
Message-ID: <20130114172221.GU14149@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Rothwell <sfr@canb.auug.org.au> [130113 18:52]:
> Hi all,
> 
> Today's linux-next merge of the arm-soc tree got a conflict in
> drivers/crypto/omap-sham.c between commit dfd061d5a8f5 ("crypto:
> omap-sham - Add code to use dmaengine API") from the crypto tree and
> commit a62a6e98c370 ("ARM: OMAP2+: Disable code that currently does not
> work with multiplaform") from the arm-soc tree.
> 
> I fixed it up (the former removed the include that the latter protected)
> and can carry the fix as necessary (no action is required).

Thanks, yes the crypto tree changes fixed up things so the changes
coming from arm-soc tree are not needed any longer.

Regards,

Tony
