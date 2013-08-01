From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 1 Aug 2013 17:48:21 +0200
Subject: [PATCH 0/9] ARM: kirkwood: convert a few more boards to DT
In-Reply-To: <1375346738-21596-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1375346738-21596-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130801154821.GG19725@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 01, 2013 at 10:45:29AM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> Here is a set of patches that converts a few additional Kirkwood
> boards to use the Device Tree. I intend to continue this effort with
> the remaining Kirkwood boards.

Hi Thomas

I think it would be good to leave one board that somebody has with
both DT and old style startup, for one or two cycles. 

I used to regularly test both on my QNAP, but its currently in a
container heading west, and i will not have access to it for a couple
of months. Is there another board we can pick which somebody has?

    Andrew
