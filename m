From: cl@linux.com (Christoph Lameter)
Date: Mon, 27 Sep 2010 10:56:09 -0500 (CDT)
Subject: [PATCH v6 0/8] ptp: IEEE 1588 hardware clock support
In-Reply-To: <20100924150246.0e6064b6@lxorguk.ukuu.org.uk>
References: <cover.1285261533.git.richard.cochran@omicron.at>
	<20100923213654.0c64b047@lxorguk.ukuu.org.uk>
	<20100924131407.GA3113@riccoc20.at.omicron.at>
	<20100924150246.0e6064b6@lxorguk.ukuu.org.uk>
Message-ID: <alpine.DEB.2.00.1009271054320.9258@router.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Fri, 24 Sep 2010, Alan Cox wrote:

> Whether you add new syscalls or do the fd passing using flags and hide
> the ugly bits in glibc is another question.

Use device specific ioctls instead of syscalls?
