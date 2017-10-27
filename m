From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 27 Oct 2017 21:39:59 +0200
Subject: [PATCH] pinctrl: armada-37xx: Add edge both type gpio irq support
In-Reply-To: <87a80c4ukf.fsf@free-electrons.com>
References: <20171019131003.9684-1-gregory.clement@free-electrons.com>
 <20171019133828.GC6615@lunn.ch> <87a80c4ukf.fsf@free-electrons.com>
Message-ID: <20171027193959.GB2385@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory

> In the end I don't think it is a problem.

I think it should be clearly documented somewhere. Hardware which can
do both edges in hardware won't have this problem. If i'm using this
generic feature, i want an idea if it is mostly going to work, or
always going to work.

   Andrew
