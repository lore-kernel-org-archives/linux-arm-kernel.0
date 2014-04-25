From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 25 Apr 2014 17:59:23 +0200
Subject: [PATCH v2 14/18] ARM: mvebu: Add support for USB cluster on the
 Armada 375 SoC
In-Reply-To: <20140425154320.GA20801@arch.cereza>
References: <1398434836-18908-1-git-send-email-gregory.clement@free-electrons.com>
 <1398434836-18908-15-git-send-email-gregory.clement@free-electrons.com>
 <20140425154320.GA20801@arch.cereza>
Message-ID: <20140425155923.GD12472@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +			 * We can't use usb2 and usb3 in the same time, so let's
> > +			 * disbale usb2 and complain about it to the user askinf
> 
> typos: disable, asking

And it should be "at the same time", not in.

    Andrew
