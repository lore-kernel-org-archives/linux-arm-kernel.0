From: broonie@kernel.org (Mark Brown)
Date: Sun, 8 Sep 2013 14:47:25 +0100
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <20130906023605.GA2292@gmail.com>
References: <593AEF6C47F46446852B067021A273D6D984000B@MUCSE039.lantiq.com>
 <20130905020435.GA3970@gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA0C7F4@DBDE04.ent.ti.com>
 <522817D7.1010206@freescale.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA0C885@DBDE04.ent.ti.com>
 <5228369A.9000904@freescale.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA0C907@DBDE04.ent.ti.com>
 <52284F32.2020302@freescale.com>
 <20130905135032.GB3084@sirena.org.uk>
 <20130906023605.GA2292@gmail.com>
Message-ID: <20130908134725.GQ29403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 05, 2013 at 10:36:44PM -0400, Huang Shijie wrote:
> On Thu, Sep 05, 2013 at 02:50:32PM +0100, Mark Brown wrote:

> > Looking at the current header there just seem to be defines in there, no
> > abstraction for the chips.  Perhaps that is what is missing?

> we do not need any abstraction for this chip, we only need the SPI NOR 
> commands, such as Quad read / DDR quad read.

So the abstraction could say what the commands are, or what's supported
if they're standard?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130908/9454044d/attachment-0001.sig>
