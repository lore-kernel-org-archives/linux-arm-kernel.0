From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 9 Jun 2015 19:01:53 +0200
Subject: [PATCH 00/34] pinctrl: mvebu: numerous fixes, cleanups and
 improvements
In-Reply-To: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20150609170153.GC16778@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 09, 2015 at 06:46:52PM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> This fairly long series of patches implement numerous fixes, cleanups
> and improvements to the description of the MPP pins on Armada 370,
> 375, 38x, 39x and XP.

...

> I wish you good luck when reviewing this. It was boring to do, so I
> guess it is going to be horribly boring to review :-)

Not so far :-)

So i mailed two specific comments, but i think there might be a
generic problem. You appear to be modifying pinctrl without making
corresponding changes to .dtsi files? Or have i just missed them?  I
would of expected the .dtsi file changes to be in the same patch, or
there are going to be bisect issues.

      Andrew
