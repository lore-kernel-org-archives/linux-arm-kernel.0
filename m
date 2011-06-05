From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sun, 5 Jun 2011 20:29:24 +0200
Subject: [PATCH] ep93xx-eth: convert to phylib
In-Reply-To: <201106051957.36492.florian@openwrt.org>
References: <201106051957.36492.florian@openwrt.org>
Message-ID: <201106052029.24742.f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 05 June 2011 19:57:36 Florian Fainelli wrote:
> ep93xx-eth lacked support for monitoring link status changes, with this
> patch, link changes are now watched and reported correctly.
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---

I just stumbled upon: http://www.mail-
archive.com/netdev at vger.kernel.org/msg62549.html
which does not seem to have been merged.

I will respin my patch with Herbert's changes
--
Florian
