From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 18 Oct 2012 14:37:02 -0400
Subject: [PATCH] ARM: kirkwood: fix LEDs names for lsxl boards
In-Reply-To: <1348519742-20126-1-git-send-email-michael@walle.cc>
References: <1348519742-20126-1-git-send-email-michael@walle.cc>
Message-ID: <20121018183702.GA14395@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2012 at 10:49:02PM +0200, Michael Walle wrote:
> Don't use the specific board name in a the common device tree include file.
> Instead use the common name 'lsxl'.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  arch/arm/boot/dts/kirkwood-lsxl.dtsi |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)

Applied to:

git://git.infradead.org/users/jcooper/linux.git kirkwood/fixes

thx,

Jason.
