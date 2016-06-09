From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 9 Jun 2016 16:10:06 +0200
Subject: [PATCH] ARM: orion: remove unreferenced board-d2net.c
In-Reply-To: <20160609153935.44323b8e@free-electrons.com>
References: <1465466656-30002-1-git-send-email-ben.dooks@codethink.co.uk>
 <20160609133116.GH30205@lunn.ch>
 <20160609153935.44323b8e@free-electrons.com>
Message-ID: <20160609141006.GK30205@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas

> That being said, this has been broken more than 2 years ago, and nobody
> noticed. Doesn't this mean that we could get rid of the support for
> this board entirely? :)

Well, all it means is the LEDs don't blink. If the disk was not
spinning, or the ethernet device missing, i would agree with you. But
somebody could be using this device and don't notice the difference
with the LEDs.

	Andrew
