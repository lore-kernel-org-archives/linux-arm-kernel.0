From: vitalywool@gmail.com (Vitaly Wool)
Date: Mon, 2 Aug 2010 17:12:08 +0200
Subject: [PATCH v2 00/20] native support for wl1271 on ZOOM
In-Reply-To: <20100802114256.GE12293@atomide.com>
References: <1279733634-21974-1-git-send-email-ohad@wizery.com>
	<20100726193028.GG3903@tuxdriver.com>
	<1280736987.17809.18.camel@chilepepper>
	<20100802114256.GE12293@atomide.com>
Message-ID: <AANLkTikvtMbqUdwHtCtdL2xXbQh64pxjApo6ZH6hAXnP@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 2, 2010 at 1:42 PM, Tony Lindgren <tony@atomide.com> wrote:

> Nicolas Pitre made a comment saying he wants to look at these patches
> more, are there other pending comments?

Yep, I'm feeling quite uncomfortable with the way platform data is
being passed over to sdio device now.

Also, specifically to 12xx, I'd like to see REF_CLOCK moved on and
have this set by platform too (I haven't found anything like that in
the patches but maybe I've overlooked that).

Thanks,
   Vitaly
