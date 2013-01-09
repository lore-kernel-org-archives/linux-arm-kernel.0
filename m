From: horms@verge.net.au (Simon Horman)
Date: Wed, 9 Jan 2013 11:07:12 +0900
Subject: [PATCH 2/2] ARM: shmobile: armadillo800eva: Reference DT
 implementation
In-Reply-To: <1355851359-8871-3-git-send-email-hechtb+renesas@gmail.com>
References: <1355851359-8871-1-git-send-email-hechtb+renesas@gmail.com>
 <1355851359-8871-3-git-send-email-hechtb+renesas@gmail.com>
Message-ID: <20130109020712.GC6496@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 18, 2012 at 06:22:39PM +0100, Bastian Hecht wrote:
> Provide alternate board code for the Armadillo 800 EVA to
> demonstrate how DT may be used given the current state of
> driver device tree support. This is intended to act as a
> reference for mach-shmobile developers.
> 
> This is based on Simon Horman's reference implementation for
> the board kzm9g.
> 
> Currently only the ethernet controller is brought up.

Thanks, looks good. I will apply this.

Could you let me know what the status of
the DT bindings for sh-eth is?
