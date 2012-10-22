From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 21 Oct 2012 23:06:24 -0400
Subject: [PATCH 1/2] ARM: kirkwood: cleanup lsxl board includes
In-Reply-To: <1350776094-16778-1-git-send-email-michael@walle.cc>
References: <1350776094-16778-1-git-send-email-michael@walle.cc>
Message-ID: <20121022030624.GH25828@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 21, 2012 at 01:34:53AM +0200, Michael Walle wrote:
> Remove unneeded includes. These are leftovers from platform device
> registrations.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  arch/arm/mach-kirkwood/board-lsxl.c |    8 --------
>  1 files changed, 0 insertions(+), 8 deletions(-)

Applied to:

git://git.infradead.org/users/jcooper/linux.git kirkwood/cleanup

thx,

Jason.
