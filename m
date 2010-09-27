From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Mon, 27 Sep 2010 18:05:58 +0100
Subject: [PATCH v6 0/8] ptp: IEEE 1588 hardware clock support
In-Reply-To: <alpine.DEB.2.00.1009271054320.9258@router.home>
References: <cover.1285261533.git.richard.cochran@omicron.at>
	<20100923213654.0c64b047@lxorguk.ukuu.org.uk>
	<20100924131407.GA3113@riccoc20.at.omicron.at>
	<20100924150246.0e6064b6@lxorguk.ukuu.org.uk>
	<alpine.DEB.2.00.1009271054320.9258@router.home>
Message-ID: <20100927180558.52817d5f@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 27 Sep 2010 10:56:09 -0500 (CDT)
Christoph Lameter <cl@linux.com> wrote:

> 
> On Fri, 24 Sep 2010, Alan Cox wrote:
> 
> > Whether you add new syscalls or do the fd passing using flags and hide
> > the ugly bits in glibc is another question.
> 
> Use device specific ioctls instead of syscalls?

Some of the ioctls are probably not device specific, the job of the OS in
part is to present a unified interface. We already have a mess of HPET
and RTC driver ioctls.

Some of it undoubtedly is device specific.

Alan
