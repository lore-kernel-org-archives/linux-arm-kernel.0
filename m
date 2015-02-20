From: eric.nelson@boundarydevices.com (Eric Nelson)
Date: Thu, 19 Feb 2015 18:27:26 -0700
Subject: [PATCH] ARM: dts: imx6qdl-sabrelite: enable HDMI
In-Reply-To: <1424387057-5575-1-git-send-email-eric.nelson@boundarydevices.com>
References: <1424387057-5575-1-git-send-email-eric.nelson@boundarydevices.com>
Message-ID: <54E68D7E.8050802@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/19/2015 04:04 PM, Eric Nelson wrote:
> Enable HDMI channel and the I2C port it uses for DDC.
> 
> Signed-off-by: Eric Nelson <eric.nelson@boundarydevices.com>
> ---
>  arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 

Nak.

An earlier patch set already added this (commits d951534, 8eedffe5).

Sorry for the noise.
