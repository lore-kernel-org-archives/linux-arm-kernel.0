From: horms@verge.net.au (Simon Horman)
Date: Thu, 17 Oct 2013 09:07:52 +0900
Subject: [PATCH] serial8250-em: convert to clk_prepare/unprepare
In-Reply-To: <20131016200651.GA26506@kroah.com>
References: <1381206268-3914-1-git-send-email-horms+renesas@verge.net.au>
 <20131016200651.GA26506@kroah.com>
Message-ID: <20131017000752.GT22321@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 16, 2013 at 01:06:51PM -0700, Greg Kroah-Hartman wrote:
> On Tue, Oct 08, 2013 at 01:24:27PM +0900, Simon Horman wrote:
> > Hi Greg,
> > 
> > please consider this enhancement from Kuribayashi-san for serial8250-em.
> > 
> > Also, please let me know if you would like us to handle serial patches
> > a different way.
> 
> No, this works for me, if it works for you, that's fine with me.

Thanks, it works for me too.
