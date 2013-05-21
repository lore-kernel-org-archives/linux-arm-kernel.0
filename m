From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 21 May 2013 18:32:50 -0400
Subject: [PATCH] arm: mvebu: enable two USB interfaces on the Armada XP
 GP board
In-Reply-To: <1369158789-3218-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369158789-3218-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130521223250.GY31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 21, 2013 at 07:53:09PM +0200, Thomas Petazzoni wrote:
> The Armada XP GP board has two USB slots: one on the front side and
> one on the back side. This commit enables the two USB host controllers
> that correspond to those wo USB slots.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-xp-gp.dts |   10 ++++++++++
>  1 file changed, 10 insertions(+)

Applied to mvebu/dt

thx,

Jason.
