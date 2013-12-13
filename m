From: balbi@ti.com (Felipe Balbi)
Date: Thu, 12 Dec 2013 22:17:19 -0600
Subject: [PATCH 3/7] usb: dwc3: pci: add pm_runtime support
In-Reply-To: <20131213015605.GC29964@psi-dev26.jf.intel.com>
References: <1386884325-11440-1-git-send-email-balbi@ti.com>
 <1386884325-11440-4-git-send-email-balbi@ti.com>
 <20131213015605.GC29964@psi-dev26.jf.intel.com>
Message-ID: <20131213041719.GB867@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 05:56:05PM -0800, David Cohen wrote:
> On Thu, Dec 12, 2013 at 03:38:41PM -0600, Felipe Balbi wrote:
> > teach the PCI glue about pm_runtime so that
> > it's easier to teach dwc3 core about it
> > later.
> > 
> > No functional changes otherwise.
> > 
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> 
> I was able to test this one with Intel Merrifield:
> Acked-by: David Cohen <david.a.cohen@linux.intel.com>

cool, thanks. Although that'd be a Tested-by. Is it ok to add your name
as Tested-by instead ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131212/857afe3a/attachment.sig>
