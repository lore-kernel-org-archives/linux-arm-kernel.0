From: broonie@kernel.org (Mark Brown)
Date: Fri, 24 Jul 2015 11:52:09 +0100
Subject: [RFC PATCH 0/2] spi: add dual parallel & stacked mode support in
 Zynq MPSoC GQSPI controller
In-Reply-To: <7CFCFE83B8145347A1D424EC939F1C3CA81D12@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1436445895-25504-1-git-send-email-ranjit.waghmode@xilinx.com>
 <20150714164005.GE11162@sirena.org.uk>
 <7CFCFE83B8145347A1D424EC939F1C3CA7E53D@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20150715160146.GS11162@sirena.org.uk>
 <7CFCFE83B8145347A1D424EC939F1C3CA7E758@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20150716085739.GT11162@sirena.org.uk>
 <7CFCFE83B8145347A1D424EC939F1C3CA81D12@XAP-PVEXMBX01.xlnx.xilinx.com>
Message-ID: <20150724105209.GI11162@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 10:42:35AM +0000, Ranjit Abhimanyu Waghmode wrote:

As I think you've been asked before please fix your mail client to word
wrap within paragraphs so your mails are more legible.

> To support the dual parallel mode in this controller, following minor
> things can be added to the driver.

> 1) Controller needs to know in which mode it is working, then it's
> obvious to set the appropriate flag for the same
> 2) There are more than one chip selects, so need to set the same
> 
> So kindly suggest your view on the above request.

I'm not entirely sure what you're asking here from the point of view of
SPI, sorry - what exactly are you requesting?  If you want to add
support for new SPI bus modes please go ahead and do that, you need to
clearly document what any new modes you're adding are so that other
people can understand them.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150724/69d936b7/attachment.sig>
