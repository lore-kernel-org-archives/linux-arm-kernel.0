From: marex@denx.de (Marek Vasut)
Date: Fri, 11 Oct 2013 22:13:42 +0200
Subject: [PATCH v7 0/2] Add PCIe support for i.MX6q
In-Reply-To: <CAJ+vNU0HJs9NxPy8Erer1ZUzCAkzhQn+c0atmEZ=ZZWLgXb6Kw@mail.gmail.com>
References: <1380165887-13506-1-git-send-email-shawn.guo@linaro.org>
 <201310111644.22844.marex@denx.de>
 <CAJ+vNU0HJs9NxPy8Erer1ZUzCAkzhQn+c0atmEZ=ZZWLgXb6Kw@mail.gmail.com>
Message-ID: <201310112213.42221.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Tim Harvey,

> Marek,
> 
> Looks like you and I are getting the same results now.  Device
> enumeration is working fine through the switch however when I attempt
> to use a device behind the switch (gige adapter in my case) I find
> that I get a few interrupts to that devices irq handler then the
> system hangs (like what occurs when a read is done to dbi without the
> pcie controllers clock running).
> 
> Anyone have any ideas?

Certainly. My Intel "igb" card now shows Link UP, sends about two packets and 
then the whole system freezes entirely. Not even my BDI3000 is able to "halt" it 
via JTAG.

btw. Tim, just a nit-pick. Top-posting into a public ML is frowned upon.

Best regards,
Marek Vasut
