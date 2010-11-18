From: tomi.valkeinen@nokia.com (Tomi Valkeinen)
Date: Thu, 18 Nov 2010 11:11:09 +0200
Subject: [PATCH 0/3] OMAP: DSS2: introduce generic panel display driver
	(try #8)
In-Reply-To: <AANLkTinP=xJ66qTZA4JTXFNH+xqvKWgV-XhExoPr6o-C@mail.gmail.com>
References: <1290000875-11508-1-git-send-email-bryan.wu@canonical.com>
	<1290003526.26444.30.camel@tubuntu>
	<AANLkTinP=xJ66qTZA4JTXFNH+xqvKWgV-XhExoPr6o-C@mail.gmail.com>
Message-ID: <1290071469.3431.4.camel@tubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-11-18 at 10:14 +0800, ext Bryan Wu wrote:
> On Wed, Nov 17, 2010 at 10:18 PM, Tomi Valkeinen

> > Are you also interested in solving the backlight issue? =)
> 
> Yeah, can I start with
> drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c. I plan to move
> the blacklight code to drivers/video/blacklight/ and let sharp_ls to
> use panel-generic-dpi.c driver.

Yes, I think that's a good solution for the panels which have a separate
backlight (ie. all these "dummy" panels"). However, I'm not sure how
that would work for panels with more integrated backlight, for example
Taal. But we don't need to worry about that right now.

 Tomi
