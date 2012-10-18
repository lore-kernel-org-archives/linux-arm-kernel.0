From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 18 Oct 2012 14:38:23 -0400
Subject: [PATCH] ARM: kirkwood: fix buttons on lsxl boards
In-Reply-To: <1348782877-857-1-git-send-email-michael@walle.cc>
References: <1348782877-857-1-git-send-email-michael@walle.cc>
Message-ID: <20121018183823.GB14395@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2012 at 11:54:37PM +0200, Michael Walle wrote:
> Change event type to switch for the power and autopower switches.
> Additionally, this patch aligns the keycodes with the other linkstation
> boards already supported by linux.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  arch/arm/boot/dts/kirkwood-lsxl.dtsi |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)

Applied to:

git://git.infradead.org/users/jcooper/linux.git kirkwood/fixes

thx,

Jason.
