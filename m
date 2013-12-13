From: david.a.cohen@linux.intel.com (David Cohen)
Date: Thu, 12 Dec 2013 17:56:05 -0800
Subject: [PATCH 3/7] usb: dwc3: pci: add pm_runtime support
In-Reply-To: <1386884325-11440-4-git-send-email-balbi@ti.com>
References: <1386884325-11440-1-git-send-email-balbi@ti.com>
 <1386884325-11440-4-git-send-email-balbi@ti.com>
Message-ID: <20131213015605.GC29964@psi-dev26.jf.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 03:38:41PM -0600, Felipe Balbi wrote:
> teach the PCI glue about pm_runtime so that
> it's easier to teach dwc3 core about it
> later.
> 
> No functional changes otherwise.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>

I was able to test this one with Intel Merrifield:
Acked-by: David Cohen <david.a.cohen@linux.intel.com>
