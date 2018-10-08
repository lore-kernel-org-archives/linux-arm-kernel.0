From: broonie@kernel.org (Mark Brown)
Date: Mon, 8 Oct 2018 23:35:55 +0100
Subject: next-20181008 build: 2 failures 22 warnings (next-20181008)
In-Reply-To: <20181008213006.GP120535@bhelgaas-glaptop.roam.corp.google.com>
References: <E1g9cV0-0008Sg-4U@optimist> <20181008212021.GB4440@sirena.org.uk>
 <20181008213006.GP120535@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <20181008223555.GC4440@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 08, 2018 at 04:30:06PM -0500, Bjorn Helgaas wrote:
> On Mon, Oct 08, 2018 at 10:20:21PM +0100, Mark Brown wrote:

> > introduced in e3fbcc7c4b130(PCI/AER: Covertly inject errors with ftrace
> > hooks).  This field is not present on arm.

> I dropped e3fbcc7c4b130 and related patches already, so this should be gone
> in my current "next" branch (18b4baa4d9fc).

Great, thanks!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181008/457d0805/attachment.sig>
