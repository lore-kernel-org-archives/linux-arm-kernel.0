From: j.neuschaefer@gmx.net (Jonathan =?utf-8?Q?Neusch=C3=A4fer?=)
Date: Mon, 27 Nov 2017 15:34:26 +0100
Subject: [PATCH 2/3] ARM: qcom_defconfig: enable MSM IOMMU for display
In-Reply-To: <20171127114458.20976-3-srinivas.kandagatla@linaro.org>
References: <20171127114458.20976-1-srinivas.kandagatla@linaro.org>
 <20171127114458.20976-3-srinivas.kandagatla@linaro.org>
Message-ID: <20171127143426.br5uhkrmxfubtmhl@latitude>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 27, 2017 at 11:44:57AM +0000, srinivas.kandagatla at linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> MSM IOMMU is required for apq8064 display, so enable it by default.

What exactly do you mean by "display"? Which ip block requires IOMMU
support?


Jonathan Neusch?fer
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171127/00e32f79/attachment.sig>
