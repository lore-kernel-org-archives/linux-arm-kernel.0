From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 21 Feb 2014 17:41:25 +0100
Subject: [PATCH 21/21] ARM: Kirkwood: Remove DT support
In-Reply-To: <1563594.ZI2UdY7FPy@wuerfel>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <20140220232438.GT7862@titan.lakedaemon.net>
 <20140221165252.6eb12cbd@skate> <1563594.ZI2UdY7FPy@wuerfel>
Message-ID: <20140221164125.GZ11878@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I'm also adding Simon Guinot to Cc here. He contributed both the kernel
> support and the Debian support for the LaCie 2Big/5Big. He might also be
> able to verify that they work after the DT conversion, or even help
> implementing it. Since there is already someone who is looking into
> t5325, that would just leave the OpenRD reference design, right?

I'm onto both t5325 and OpenRD.

Thomas provided me with a basic t5325 DTS file from around kernel
version v3.5 which i have brought up to date. I'm now trying to get my
head around ASOC and simple-card, i.e. do it properly using DT.

OpenRD i'm at the same stage, just audio left, although i suspect i
will get some interesting comments for how i handled command line
parsing and enabling devices. I have a volunteer testing it, but
feedback is slow.

	 Andrew
