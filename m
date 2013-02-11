From: tony@atomide.com (Tony Lindgren)
Date: Mon, 11 Feb 2013 11:00:11 -0800
Subject: [PATCH 1/1] ARM: OMAP4: Add OMAP4 Blaze Tablet support
In-Reply-To: <51193DE1.6080704@ti.com>
References: <1360352269-14922-1-git-send-email-ruslan.bilovol@ti.com>
 <1360352269-14922-2-git-send-email-ruslan.bilovol@ti.com>
 <20130210025225.GB4801@atomide.com> <51193DE1.6080704@ti.com>
Message-ID: <20130211190011.GS4801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jon Hunter <jon-hunter@ti.com> [130211 10:58]:
> 
> Please note that the blaze is derived from the omap4-sdp board and so I
> would hope that we can use the existing for sdp dts and board file for
> blaze. In fact this is what I do today for basic booting.
> 
> So unless there is some feature on the blaze that is not compatible with
> the original sdp, we should just use the sdp dts.

Sounds like we need some common .dts file and separate files
for sdp, blaze and tablet that include the common .dts file?

There's a different LCD panel at least between blaze and the
tablet.

Regards,

Tony
