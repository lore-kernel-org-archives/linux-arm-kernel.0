From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 17 Dec 2012 20:52:06 +0000 (UTC)
Subject: [PATCH] ARM: OMAP4: PRM: Correct reset source map
In-Reply-To: <1355776640-369-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1355776640-369-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <alpine.DEB.2.00.1212172050290.29833@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Mon, 17 Dec 2012, Ivan Khoronzhuk wrote:

> In the map for reset sources register we use defines intended for
> using with PRM_RSTCTRL register. So fix it.

your changes look good, but they are missing Signed-off-by: lines.  Could 
you please either resend with those, or confirm that you intended to add 
them?  You may wish to read Documentation/SubmittingPatches, particularly 
item 12.


- Paul
