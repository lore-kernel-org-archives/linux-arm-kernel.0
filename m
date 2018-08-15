From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 15 Aug 2018 02:46:36 +0200
Subject: serdev: How to attach serdev devices to USB based tty devices?
In-Reply-To: <3639955d-5990-1c82-7158-ac07b33c41f2@suse.de>
References: <3639955d-5990-1c82-7158-ac07b33c41f2@suse.de>
Message-ID: <20180815004636.GB11610@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andreas

This not my area of expertise. But i wanted to point out that there
exists a mechanism to make the FDTI driver release a port so that it
can be used from user space, e.g. for JTAG. It might be possible to
extend this mechanism to make the FTDI driver perform the registration
to serdev.

It is however not a generic solution.

   Andrew
