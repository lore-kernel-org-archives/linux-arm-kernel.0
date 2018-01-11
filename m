From: robh@kernel.org (Rob Herring)
Date: Thu, 11 Jan 2018 16:11:45 -0600
Subject: [PATCH V4 2/2] ARM: dts: imx7s: add snvs rtc clock
In-Reply-To: <1515491526-14060-2-git-send-email-Anson.Huang@nxp.com>
References: <1515491526-14060-1-git-send-email-Anson.Huang@nxp.com>
 <1515491526-14060-2-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180111221145.7bmkxsqmx7qjw3tq@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 09, 2018 at 05:52:06PM +0800, Anson Huang wrote:
> Add i.MX7 SNVS RTC clock.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> change since v3:
> 	add optional for clocks in binding doc statement.
>  Documentation/devicetree/bindings/crypto/fsl-sec4.txt | 17 +++++++++++++++++
>  arch/arm/boot/dts/imx7s.dtsi                          |  2 ++
>  2 files changed, 19 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
