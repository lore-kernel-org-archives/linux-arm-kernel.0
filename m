From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 26 Apr 2016 21:09:26 +0200
Subject: [PATCH v2 0/2] pci: host: new driver for Marvell Armada 7K/8K
 PCIe controller
In-Reply-To: <20160426170004.GA27803@localhost>
References: <1460648177-31473-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160425154611.3e7e9dc9@free-electrons.com>
 <20160425172846.GB1759@localhost>
 <20160426104208.150cbbd0@free-electrons.com>
 <20160426170004.GA27803@localhost>
Message-ID: <20160426210926.7028d15d@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 26 Apr 2016 12:00:04 -0500, Bjorn Helgaas wrote:

> > So my v3 implements what you suggested, and creates a
> > armada8k_add_pcie_port() to make it consistent with the other drivers,
> > but long term, I'm not sure this particular function is really useful.
> 
> I agree completely with everything you said.  I would be thrilled if
> somebody were to make this more sensible, as long as we did it to
> *all* the drivers, not just one.

OK. I'll see if I can come up with a few patches. Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
