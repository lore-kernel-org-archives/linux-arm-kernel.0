From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Sun, 25 Mar 2012 13:48:16 +0200
Subject: uImage with integrated dtb file
In-Reply-To: <4F6E5D5B.8050306@antcom.de>
References: <4F6E5D5B.8050306@antcom.de>
Message-ID: <20120325114816.GA13903@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Roland Stigge wrote:
> Hi,
> 
> since I will need to maintain some machines with DT enabled kernels but 
> containing a U-Boot without DT support, I sometimes need to integrate a 
> dtb file into uImage.

I use the new image format that is itself based on FDT and has support for
appending a DTB. Some documentation can be found here:

	http://git.denx.de/u-boot.git/?p=u-boot.git;a=tree;f=doc/uImage.FIT

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120325/02582b30/attachment.sig>
