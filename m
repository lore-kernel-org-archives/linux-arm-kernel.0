From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 4 May 2014 20:56:25 -0400
Subject: [PATCH 02/15] ARM: dts: kirkwood: add node labels
In-Reply-To: <1398862602-29595-3-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1398862602-29595-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1398862602-29595-3-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20140505005625.GD28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 30, 2014 at 02:56:29PM +0200, Sebastian Hesselbarth wrote:
> This adds missing node labels to Kirkwood common and SoC specific nodes
> to allow to reference them more easily.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: devicetree at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/boot/dts/kirkwood-6192.dtsi | 10 +++++-----
>  arch/arm/boot/dts/kirkwood-6281.dtsi | 10 +++++-----
>  arch/arm/boot/dts/kirkwood-6282.dtsi | 16 ++++++++--------
>  arch/arm/boot/dts/kirkwood.dtsi      | 16 ++++++++--------
>  4 files changed, 26 insertions(+), 26 deletions(-)

Patches 2 through 15 applied to mvebu/dt with Andrew's Ack.

thx,

Jason.
