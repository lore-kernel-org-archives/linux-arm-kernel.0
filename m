From: horms@verge.net.au (Simon Horman)
Date: Wed, 9 Jan 2013 11:06:47 +0900
Subject: [PATCH 1/2] ARM: r8a7740: Add interim sh-eth device name to
 clocks list
In-Reply-To: <1355851359-8871-2-git-send-email-hechtb+renesas@gmail.com>
References: <1355851359-8871-1-git-send-email-hechtb+renesas@gmail.com>
 <1355851359-8871-2-git-send-email-hechtb+renesas@gmail.com>
Message-ID: <20130109020647.GB6496@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 18, 2012 at 06:22:38PM +0100, Bastian Hecht wrote:
> When we use the ethernet device via DT setup, we need to add it
> to a lookup list until this is properly handled later in a DT-only
> fashion.

Thanks, looks good.
I will apply this.
