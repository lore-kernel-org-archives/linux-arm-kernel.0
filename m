From: Li.Xiubo@freescale.com (Li.Xiubo at freescale.com)
Date: Tue, 2 Sep 2014 03:22:24 +0000
Subject: [PATCHv1 1/7] ASoC: simple-card: Merge single and muti DAI link
 code.
In-Reply-To: <20140901151356.GB29327@sirena.org.uk>
References: <1409545781-20530-1-git-send-email-Li.Xiubo@freescale.com>
 <1409545781-20530-2-git-send-email-Li.Xiubo@freescale.com>
 <20140901133412.GA11312@lunn.ch> <20140901151356.GB29327@sirena.org.uk>
Message-ID: <1b29c16ac3944bb19940da886bf7da3a@BY2PR0301MB0613.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> On Mon, Sep 01, 2014 at 03:34:12PM +0200, Andrew Lunn wrote:
> > On Mon, Sep 01, 2014 at 12:29:35PM +0800, Xiubo Li wrote:
> > > This patch merge single DAI link and muti-DAI links code together,
> > > and simply the simple-card driver code.
> 
> > It would be good to note that this breaks the Binary API with DT
> > blobs. Old blobs will not work with this new C code.
> 
> That's not on, we need to maintian compatibility with the old DTs unless
> there's a very strong reason not to.  Revising the binding is one option
> for doing this, keeping the old binding in place and making a v2 binding
> with the new functionality.

Yes, agree.

Actually, the current code is a bit more complicated that we should keep in mind
of two styles of single DAI link and muti-DAI links. And the binding document and
code are a little unreadable.

For others must read the simple card code carefully to add one DT node.

Thanks,

BRs
