From: kubakici@wp.pl (Jakub Kicinski)
Date: Thu, 7 Dec 2017 15:56:39 -0800
Subject: [PATCH net-next v3 0/2] net: thunderx: add support for PTP clock
In-Reply-To: <20171206133100.26436-1-aleksey.makarov@cavium.com>
References: <20171206133100.26436-1-aleksey.makarov@cavium.com>
Message-ID: <20171207155639.0787247a@cakuba.netronome.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed,  6 Dec 2017 16:30:56 +0300, Aleksey Makarov wrote:
> This series adds support for IEEE 1588 Precision Time Protocol
> to Cavium ethernet driver.
> 
> The first patch adds support for the Precision Time Protocol Clocks and
> Timestamping coprocessor (PTP) found on Cavium processors.
> It registers a new PTP clock in the PTP core and provides functions
> to use the counter in BGX, TNS, GTI, and NIC blocks.
> 
> The second patch introduces support for the PTP protocol to the
> Cavium ThunderX ethernet driver.

Since this is PTP-related, would it make sense to CC Richard Cochran 
on the next revision?
