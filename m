From: w@1wt.eu (Willy Tarreau)
Date: Sun, 12 Feb 2017 02:24:18 +0100
Subject: [PATCH] ARM: dts: armada-385-synology-ds116: add support for
 Synology DS116 NAS
In-Reply-To: <20170212011744.GB7328@lunn.ch>
References: <1486805073-15534-1-git-send-email-w@1wt.eu>
 <20170212004031.GA7328@lunn.ch> <20170212005350.GA18612@1wt.eu>
 <20170212011744.GB7328@lunn.ch>
Message-ID: <20170212012418.GA17841@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 12, 2017 at 02:17:44AM +0100, Andrew Lunn wrote:
> > But won't that squat the I/O address and prevent me from using all the
> > other codes via the regular serial port ?
> 
> Nope. That driver hijacks the serial port during shutdown to actually
> turn the power off. The rest of the time, it does not touch the serial
> port. Userspace, or the rest of the kernel is free to use it.

OK so I should declare both the serial and the power-off device at the
same address ? Excuse-me for the dumb question but I'm not much used to
doing uncommon things in DTS files :-/

Willy
