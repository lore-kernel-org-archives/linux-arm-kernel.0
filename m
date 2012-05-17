From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 May 2012 10:17:03 +0100
Subject: [RFC] pl08x: don't use dma_slave_config direction argument
In-Reply-To: <4FB3AD72.2010501@antcom.de>
References: <20120516110451.GA9571@n2100.arm.linux.org.uk>
 <4FB39C62.3030305@antcom.de> <20120516125253.GD9571@n2100.arm.linux.org.uk>
 <4FB3A5E7.7060505@antcom.de> <20120516131720.GE9571@n2100.arm.linux.org.uk>
 <4FB3AD72.2010501@antcom.de>
Message-ID: <20120517091703.GH9571@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2012 at 03:36:50PM +0200, Roland Stigge wrote:
> Works fine now, including series 1-7.

Great, I'll re-post the series, and then maybe we can get some tested-bys
on it.

I think it's too close to the merge window to consider queuing it up for
this window - so I think it'll have to wait until the following window.
That will give it a reasonable amount of time to sit in linux-next and
hopefully any users of it will report any problems.
