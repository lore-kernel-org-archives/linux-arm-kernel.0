From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 16 Apr 2018 15:29:39 +0800
Subject: [PATCH v2] arm: dts: hummingboard: convert onboard audio to
 simple-audio-card
In-Reply-To: <20180319201414.29481-1-mporter@konsulko.com>
References: <20180319201414.29481-1-mporter@konsulko.com>
Message-ID: <20180416072938.GD25429@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 19, 2018 at 04:14:13PM -0400, Matt Porter wrote:
> The HB onboard audio currently makes use of the imx-audio-sgtl5000
> binding. This binding does not support auxiliary audio devices such
> as external amplifiers. The simple-audio-card binding does support
> this property which allows systems incorporating the HB to add an
> auxiliary device that's attached to the HB audio jack with an
> overlay. Convert the HB onboard audio to use simple-audio-card for
> this additional flexibility.
> 
> Signed-off-by: Matt Porter <mporter@konsulko.com>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
