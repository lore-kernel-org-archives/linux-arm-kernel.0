From: broonie@kernel.org (Mark Brown)
Date: Mon, 24 Mar 2014 16:27:47 +0000
Subject: [PATCH 2/4] arm64: topology: Add support for topology DT bindings
In-Reply-To: <20140324160236.GB16245@red-moon>
References: <1395422881-10029-1-git-send-email-broonie@kernel.org>
 <1395422881-10029-2-git-send-email-broonie@kernel.org>
 <20140324153611.GA16245@red-moon>
 <20140324154550.GL2269@sirena.org.uk>
 <20140324160236.GB16245@red-moon>
Message-ID: <20140324162747.GM2269@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 24, 2014 at 04:02:36PM +0000, Lorenzo Pieralisi wrote:
> On Mon, Mar 24, 2014 at 03:45:50PM +0000, Mark Brown wrote:

> > of_get_cpu_node() doesn't visibly take a reference and isn't documented
> > as doing such?

> of_parse_phandle() does, am I right ?

Oh, yes.  I was looking at the wrong thing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140324/aa18d266/attachment.sig>
