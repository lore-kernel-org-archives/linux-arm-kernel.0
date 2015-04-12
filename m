From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 12 Apr 2015 22:04:20 +0200
Subject: [PATCH] v4l: omap4iss: Replace outdated OMAP4 control pad API
 with syscon
In-Reply-To: <1428841693-15109-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <3292592.cickJMVhRq@wuerfel>
 <1428841693-15109-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <3942354.hKemp4fIKP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 12 April 2015 15:28:13 Laurent Pinchart wrote:
> 
> Hi Arnd,
> 
> This patch doesn't depend nor conflict with the OMAP4 ISS patches scheduled to
> be merged in v4.1. If Mauro is fine with that, and if it makes your life
> easier, it could get merged through the arm-soc tree. Please let me know what
> you prefer.

I think it's fine to merge it through the media/staging tree as normal.
I'm not as worried about bisection problems in staging drivers as elsewhere.

Thanks a lot for addressing this properly!

	Arnd
