From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 18 Feb 2014 19:42:42 +0100
Subject: [PATCH v2 05/23] ARM: Kirkwood: Seperate board-dt from common
 and pcie code.
In-Reply-To: <20140218183746.GH29304@obsidianresearch.com>
References: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
 <1392459621-24003-6-git-send-email-andrew@lunn.ch>
 <3017687.o0PD1Sf7lM@wuerfel> <20140215140505.GB26088@lunn.ch>
 <20140218183746.GH29304@obsidianresearch.com>
Message-ID: <20140218184242.GJ17984@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Can we worry about this after Andrew's shuffling is done?

Hi Jason

I think so. I plan to keep to a config option for the moment and
remove the wt-override from DT. We can put it back again later.

       Andrew
