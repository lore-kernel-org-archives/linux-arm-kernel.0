From: me@felipebalbi.com (Felipe Balbi)
Date: Wed, 30 Dec 2009 01:51:13 +0200
Subject: [patch-v2.6.33-rc2+ 01/12] arm: omap: musb: ioremap only
	what's ours
In-Reply-To: <1262127092-14878-2-git-send-email-felipe.balbi@nokia.com>
References: <1262127092-14878-1-git-send-email-felipe.balbi@nokia.com>
	<1262127092-14878-2-git-send-email-felipe.balbi@nokia.com>
Message-ID: <1262130673.28789.118.camel@gandalf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2009-12-30 at 00:51 +0200, Felipe Balbi wrote:
> omap3430 TRM says the OTG address space is 4k, not 8k.

further explanation is that the address space for musb module is 4k and
the extra 4k is for L4 interconnect. I'll change the description on the
branch Tony will pull from.

-- 
balbi
