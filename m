From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 12 May 2014 16:33:17 +0200
Subject: [PATCH 0/2] ARM: mvebu: fix PCIe/mvebu-soc-id issue
In-Reply-To: <1399903900-29977-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1399903900-29977-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140512143317.GA9388@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 12, 2014 at 04:11:38PM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> This set of two patches (and more specifically the second patch) fix a
> PCIe detection problem caused by the introduction of the mvebu-soc-id
> and a bad interaction between the clock manipulation done by the
> mvebu-soc-id code and the PCIe driver. The details are all in the
> commit log of the second patch.
> 
> This second patch fixes a PCIe detection problem noticed by several
> persons.

Hi Thomas

Thanks for the patches. The wifi devices on my kirkwood B3 has now
re-appeared.

Tested-by: Andrew Lunn <andrew@lunn.ch>

	   Andrew
