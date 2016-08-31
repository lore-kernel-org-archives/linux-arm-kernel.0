From: robh@kernel.org (Rob Herring)
Date: Wed, 31 Aug 2016 10:15:27 -0500
Subject: [PATCH 5/8] arm: orion5x: Add DT include for mv88f5181
In-Reply-To: <1472203264-21089-6-git-send-email-jm@lentin.co.uk>
References: <1468679348-10522-1-git-send-email-jm@lentin.co.uk>
 <1472203264-21089-1-git-send-email-jm@lentin.co.uk>
 <1472203264-21089-6-git-send-email-jm@lentin.co.uk>
Message-ID: <20160831151527.GA12171@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 26, 2016 at 10:21:01AM +0100, Jamie Lentin wrote:
> Common definitions for the SoC for board definitions to use.
> 
> Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
> ---
>  .../bindings/arm/marvell/marvell,orion5x.txt       |  1 +
>  arch/arm/boot/dts/orion5x-mv88f5181.dtsi           | 49 ++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
>  create mode 100644 arch/arm/boot/dts/orion5x-mv88f5181.dtsi

Acked-by: Rob Herring <robh@kernel.org>
