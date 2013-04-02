From: olof@lixom.net (Olof Johansson)
Date: Tue, 2 Apr 2013 08:58:17 -0700
Subject: [PATCH] ARM: LPC32xx: changed lpc23xx_restart to lpc32xx_restart
In-Reply-To: <1362601138-16550-1-git-send-email-martinknoll@me.com>
References: <1362601138-16550-1-git-send-email-martinknoll@me.com>
Message-ID: <20130402155817.GA25867@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 06, 2013 at 09:18:58PM +0100, Martin Knoll wrote:
> This function has an odd name. This is probably a typo.

You should cc the platform maintainer on these kind of patches (Roland Stigge).
But it seems that he's not actually listed in MAINTAINERS.

Roland, can you send a patch adding yourself as LPC32XX maintainer so these
kind of patches don't get dropped? Thanks!


-Olof
