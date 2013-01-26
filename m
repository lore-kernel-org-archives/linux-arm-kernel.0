From: jhovold@gmail.com (Johan Hovold)
Date: Sat, 26 Jan 2013 16:44:15 +0100
Subject: [PATCH 0/3] atmel_lcdfb: fix 16-bpp regression
In-Reply-To: <1355142530-10366-1-git-send-email-jhovold@gmail.com>
References: <1355142530-10366-1-git-send-email-jhovold@gmail.com>
Message-ID: <20130126154415.GA25750@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 10, 2012 at 01:28:47PM +0100, Johan Hovold wrote:
> These patches fix a regression in 16-bpp support for older SOCs which use
> IBGR:555 rather than BGR:565 pixel layout. Use SOC-type to determine if the
> controller uses the intensity-bit and restore the old layout in that case.

I understand the maintainer's been busy lately, but could someone pick
these regression fixes up so we can get them into v3.8-rc and the stable
trees?

Thanks,
Johan
