From: robh@kernel.org (Rob Herring)
Date: Sun, 17 Jul 2016 15:36:44 -0500
Subject: [PATCH v0 03/10] arm: orion5x: Add clk support for mv88f5181
In-Reply-To: <1468679348-10522-4-git-send-email-jm@lentin.co.uk>
References: <1468679348-10522-1-git-send-email-jm@lentin.co.uk>
 <1468679348-10522-4-git-send-email-jm@lentin.co.uk>
Message-ID: <20160717203644.GA15594@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 16, 2016 at 03:29:01PM +0100, Jamie Lentin wrote:
> Referring to values in the u-boot port, add support for the mv88f5181
> 
> Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
> ---
>  .../devicetree/bindings/clock/mvebu-core-clock.txt |  1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/clk/mvebu/orion.c                          | 70 ++++++++++++++++++++++
>  2 files changed, 71 insertions(+)
