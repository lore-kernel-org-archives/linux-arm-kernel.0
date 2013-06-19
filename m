From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 19 Jun 2013 13:42:40 +0200
Subject: [PATCH v2 2/8] PCI: Add registry of MSI chips
In-Reply-To: <20130618224844.GC16134@google.com>
References: <1370536888-8871-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1370536888-8871-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130618224844.GC16134@google.com>
Message-ID: <20130619134240.3ffa8f7c@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Bjorn Helgaas,

On Tue, 18 Jun 2013 16:48:44 -0600, Bjorn Helgaas wrote:

> I don't really understand why the msi_chip_list lives here, since
> nothing in drivers/pci/msi.c uses it.  Seems like maybe something
> that could be in the OF code somewhere?

Ok, I'll move this to drivers/of/, we'll see what Grant says about
this. Will be part of v3.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
