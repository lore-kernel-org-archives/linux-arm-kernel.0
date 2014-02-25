From: balbi@ti.com (Felipe Balbi)
Date: Mon, 24 Feb 2014 23:00:53 -0600
Subject: [Patch v7 2/2] dmaengine: add Qualcomm BAM dma driver
In-Reply-To: <20140225030459.GN25940@sirena.org.uk>
References: <1393283500-18599-1-git-send-email-agross@codeaurora.org>
 <1393283500-18599-3-git-send-email-agross@codeaurora.org>
 <20140225000913.GA10801@saruman.home>
 <20140225030459.GN25940@sirena.org.uk>
Message-ID: <20140225050053.GA15411@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 12:05:00PM +0900, Mark Brown wrote:
> On Mon, Feb 24, 2014 at 06:09:13PM -0600, Felipe Balbi wrote:
> 
> > > +	depends on ARCH_QCOM || (COMPILE_TEST && OF && ARM)
> 
> > do you really want to make it depend on ARM even when COMPILE_TEST=y ?
> 
> writel_relaxed() is unfortunately not generally available so it'd fail
> to build on platforms like x86.

bummer

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140224/dd972371/attachment.sig>
