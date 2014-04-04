From: pavel@denx.de (Pavel Machek)
Date: Fri, 4 Apr 2014 12:28:15 +0200
Subject: [PATCH v2 4/6] ARM: socfpga: dts: add can0+1
In-Reply-To: <1396422700-3962-4-git-send-email-s.trumtrar@pengutronix.de>
References: <1396422700-3962-1-git-send-email-s.trumtrar@pengutronix.de>
 <1396422700-3962-4-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <20140404102815.GA9242@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2014-04-02 09:11:38, Steffen Trumtrar wrote:
> Add both can controllers to the dtsi.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

I have had similar patch here, except that it only listed 2 interrupts
for each d_can controller.

Otherwise it looks identical.

Reviewed-by: Pavel Machek <pavel@denx.de>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
