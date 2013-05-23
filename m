From: w@1wt.eu (Willy Tarreau)
Date: Thu, 23 May 2013 02:13:53 +0200
Subject: [PATCH 0/4] Marvell PCIe driver improvements
In-Reply-To: <1369228358-32580-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369228358-32580-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130523001353.GH31625@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Wed, May 22, 2013 at 03:12:34PM +0200, Thomas Petazzoni wrote:
> Bjorn, Jason, Andrew, Gregory,
> 
> You'll find in this patch series 4 small patches that make various
> improvements to the Marvell PCIe driver.
(...)

FWIW, these patches applied on top of your pcie-v10 tree have made
my mini-pcie dual-nic appear for the first time on the mirabox. Till
now I never knew if it was a hardware or software issue since the NIC
does not appear in u-boot nor lspci, whatever the kernel versions,
including the original Marvell one's. The NIC has two functions (one
per controller) and no bridge, so it may be a side effect of your
improvements (or maybe you fixed a bug).

Anyway for me it's a great improvement !

I've not tried it on the OpenBlocks AX3 yet (it was not detected
there previously). But I have good hopes.

For reference, the NIC is Jetway's ADMPEIDLA (intel i350-AM2).

Best regards,
Willy
