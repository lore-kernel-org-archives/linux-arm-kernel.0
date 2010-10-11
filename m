From: cjb@laptop.org (Chris Ball)
Date: Mon, 11 Oct 2010 17:59:29 +0100
Subject: [PATCH 0/6] SD/MMC driver for MX25/35/51
In-Reply-To: <20101011164459.GB476@pengutronix.de>
References: <1286806866-19258-1-git-send-email-w.sang@pengutronix.de>
	<20101011163255.GA21335@void.printf.net>
	<20101011164459.GB476@pengutronix.de>
Message-ID: <20101011165929.GB21335@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Mon, Oct 11, 2010 at 06:44:59PM +0200, Wolfram Sang wrote:
> > Mind fixing up the >80 char lines in the last two patches?  It's just:
> 
> Sigh, I don't think it will help the readability of the code, but if it can't
> be helped...

Okay.  Perhaps as a compromise, just reflow the two lines in 5/6 and
leave the long prototypes in 6/6 as they are?  (For the second hunk
in 5/6, you could just pull the start of the line back two cols.)

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
