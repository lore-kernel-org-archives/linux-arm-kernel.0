From: linux@prisktech.co.nz (Tony Prisk)
Date: Tue, 25 Sep 2012 07:14:15 +0000
Subject: linux-next: manual merge of the arm-soc tree with the  tree
In-Reply-To: <20120925163724.703a41b9438fbaef84b7480e@canb.auug.org.au>
References: <20120925163724.703a41b9438fbaef84b7480e@canb.auug.org.au>
Message-ID: <1348557420.18425.0.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-09-25 at 16:37 +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the arm-soc tree got a conflict in
> Documentation/devicetree/bindings/usb/platform-uhci.txt between commit
> 100d45970327 ("ARM: vt8500: Add support for UHCI companion controller")
> from the usb tree and commit 95e9fd10f06c ("arm: vt8500: doc: Add device
> tree bindings for arch-vt8500 devices") from the arm-soc tree.
> 
> I used the version from the arm-soc tree and can carry the fix as
> necessary (no action is required).
> 

Both versions were the same (my bad for not removing it from the arm-soc
patch).
Thanks Stephen

Regards

Tony P
