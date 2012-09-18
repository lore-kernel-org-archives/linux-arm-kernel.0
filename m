From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 18 Sep 2012 09:28:52 +0800
Subject: [PATCH 12/34] media: mx1_camera: remove the driver
In-Reply-To: <Pine.LNX.4.64.1209171031010.1689@axis700.grange>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
 <1347860103-4141-13-git-send-email-shawn.guo@linaro.org>
 <Pine.LNX.4.64.1209171031010.1689@axis700.grange>
Message-ID: <20120918012848.GE1338@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2012 at 10:33:25AM +0200, Guennadi Liakhovetski wrote:
> Ok, it used to compile not-so-long-ago, but it doesn't seem to be cared 
> for a lot lately. Let's give Paulius a bit more time to react to this 
> mail, otherwise I'll have no objections. Just as an idea, to make it a bit 
> milder we could first mark it BROKEN and add to remove schedule... But I 
> don't mind either way.
> 
I chose to remove the driver completely rather than marking it BROKEN
because the removal of the driver cleans up platform code a lot :)

Ok, if we hear anything back from Paulius in the next couple of weeks,
I keep the driver there with BROKEN marked.

Regards,
Shawn
