From: gnomes@lxorguk.ukuu.org.uk (Alan Cox)
Date: Thu, 25 May 2017 14:29:20 +0100
Subject: [PATCH 1/1] xilinx ps uart: Adding a kernel parameter for the
 number of xilinx ps uarts
In-Reply-To: <b5a032c8-db86-c16b-750f-10aa2a132248@xilinx.com>
References: <20170520022154.6766-1-kernel.development@povil.us>
 <20170520172008.5a979e8a@alans-desktop>
 <517d864d-d230-3abc-eb3c-4b628dc4625f@xilinx.com>
 <20170522192636.5b578d89@alans-desktop>
 <1668f36e-f9be-7008-004a-e467a6813e0f@xilinx.com>
 <20170523210710.4e84dd2d@alans-desktop>
 <924433a1-7e27-6eb6-71ca-ed7baceb427f@xilinx.com>
 <20170524143108.682a548d@alans-desktop>
 <b5a032c8-db86-c16b-750f-10aa2a132248@xilinx.com>
Message-ID: <20170525142920.1d662467@alans-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Ok. Is there any problem if uart_register_driver is called for every
> instance separately with nr=1? This driver has major 0, minor 0. Based

If you are doing that level of code restructuring none that I am aware
of, and if you find one I'm happy to work on fixing it.

Alan
