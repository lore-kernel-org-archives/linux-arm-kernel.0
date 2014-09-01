From: broonie@kernel.org (Mark Brown)
Date: Mon, 1 Sep 2014 16:13:56 +0100
Subject: [PATCHv1 1/7] ASoC: simple-card: Merge single and muti DAI link
 code.
In-Reply-To: <20140901133412.GA11312@lunn.ch>
References: <1409545781-20530-1-git-send-email-Li.Xiubo@freescale.com>
 <1409545781-20530-2-git-send-email-Li.Xiubo@freescale.com>
 <20140901133412.GA11312@lunn.ch>
Message-ID: <20140901151356.GB29327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 01, 2014 at 03:34:12PM +0200, Andrew Lunn wrote:
> On Mon, Sep 01, 2014 at 12:29:35PM +0800, Xiubo Li wrote:
> > This patch merge single DAI link and muti-DAI links code together,
> > and simply the simple-card driver code.

> It would be good to note that this breaks the Binary API with DT
> blobs. Old blobs will not work with this new C code.

That's not on, we need to maintian compatibility with the old DTs unless
there's a very strong reason not to.  Revising the binding is one option
for doing this, keeping the old binding in place and making a v2 binding
with the new functionality.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140901/4648ac55/attachment-0001.sig>
