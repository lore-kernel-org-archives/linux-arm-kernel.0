From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Thu, 28 Jun 2018 06:56:30 +0200
Subject: [PATCH v3 18/24] drm/sun4i: DW HDMI PHY: Add support for second
 PLL
In-Reply-To: <CAGb2v651RGegpAi-2efhBUkyFf1iC+zxOGTbRkmjuWcYSTgYJw@mail.gmail.com>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
 <20180625120304.7543-19-jernej.skrabec@siol.net>
 <CAGb2v651RGegpAi-2efhBUkyFf1iC+zxOGTbRkmjuWcYSTgYJw@mail.gmail.com>
Message-ID: <52771065.UHJ1SZMy5a@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?etrtek, 28. junij 2018 ob 04:25:54 CEST je Chen-Yu Tsai napisal(a):
> On Mon, Jun 25, 2018 at 8:02 PM, Jernej Skrabec <jernej.skrabec@siol.net> 
wrote:
> > Some DW HDMI PHYs, like those found in A64 and R40 SoCs, can select
> > between two clock parents.
> > 
> > Add code which reads second PLL from DT.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> 
> This patch by itself does not do anything. It should be merged with the
> next one.

Maxime said clock changes should be separated from DT changes.
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/578775.html

Best regards,
Jernej
