From: emil@limesaudio.com (Emil Lundmark)
Date: Fri, 7 Oct 2016 16:12:25 +0200
Subject: [PATCH 1/2] ARM: imx: fix integer overflow in AV PLL round rate
In-Reply-To: <1475752331-19525-1-git-send-email-emil@limesaudio.com>
References: <1475752331-19525-1-git-send-email-emil@limesaudio.com>
Message-ID: <20161007141224.GA18011@lime>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I realize that the two patches in this series does not actually depend on
each other. This is my first contribution to Linux so I wonder if I should
resubmit these as two separate patches instead?

For example, what if the second patch in the series is not needed? Do you
only accept the first patch then? Or what if I need to revise the second
patch? It seems unnecessary to include the first patch in that case.

I also got the threading wrong, but thats another story.

-- 
Emil Lundmark
