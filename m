From: robh@kernel.org (Rob Herring)
Date: Mon, 13 Aug 2018 17:01:51 -0600
Subject: [PATCH] ARM: dts: imx7ulp: update pinfunc header file
In-Reply-To: <1532988635-4726-1-git-send-email-Anson.Huang@nxp.com>
References: <1532988635-4726-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180813230151.GA28201@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2018 at 06:10:35AM +0800, Anson Huang wrote:
> The i.MX7ULP B0 chip has some pin changes for USB and VIU
> module, update pinfunc header file accordingly.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm/boot/dts/imx7ulp-pinfunc.h | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
