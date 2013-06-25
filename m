From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 25 Jun 2013 22:57:06 +0200
Subject: [PATCH 1/4] usb: gadget: s3c-hsotg: Allow driver instantiation
 using device tree
In-Reply-To: <20130625204632.GB9748@arwen.pp.htv.fi>
References: <1372174706-5459-1-git-send-email-t.figa@samsung.com>
 <1372174706-5459-2-git-send-email-t.figa@samsung.com>
 <20130625204632.GB9748@arwen.pp.htv.fi>
Message-ID: <5782443.xpFZv1Saq0@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 of June 2013 23:46:32 Felipe Balbi wrote:
> On Tue, Jun 25, 2013 at 05:38:23PM +0200, Tomasz Figa wrote:
> > This patch adds OF match table to the driver to allow instantiating it
> > using device tree.
> > 
> > Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> when will this driver get merged into dwc2 ?

What's dwc2? I can only see dwc3 in mainline kernel tree and it doesn't 
seem to be compatible with s3c-hsotg.

Best regards,
Tomasz
