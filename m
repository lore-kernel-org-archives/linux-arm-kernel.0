From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 Jun 2017 19:54:45 +0100
Subject: [PATCHv2 9/9] spi: spidev: add Aardvark to device tree
 compatibility list
In-Reply-To: <1498578321-13980-10-git-send-email-amelie.delaunay@st.com>
References: <1498578321-13980-1-git-send-email-amelie.delaunay@st.com>
 <1498578321-13980-10-git-send-email-amelie.delaunay@st.com>
Message-ID: <20170628185445.fsnqs2tlqqeqzl57@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 27, 2017 at 05:45:21PM +0200, Amelie Delaunay wrote:
> This patch adds an entry for the TotalPhase Aardvark SPI Host Adapter,
> which can operate as an SPI Slave.

What does this device actually do and why is spidev a sensible fit for
it?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170628/8c2666f0/attachment-0001.sig>
