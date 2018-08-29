From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 29 Aug 2018 14:15:04 +0200
Subject: [PATCH v5 1/2] devicetree/bindings: display: Add document for
 rockchip RGB output
In-Reply-To: <2858027f-69f5-57ee-d14a-2f0b329e8e0e@ysoft.com>
References: <1535443954-38806-1-git-send-email-hjc@rock-chips.com>
 <1535443954-38806-2-git-send-email-hjc@rock-chips.com>
 <2858027f-69f5-57ee-d14a-2f0b329e8e0e@ysoft.com>
Message-ID: <1862757.LMSXp8aoQ6@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

Am Dienstag, 28. August 2018, 10:31:15 CEST schrieb Michal Vok??:
> On 28.8.2018 10:12, Sandy Huang wrote:
> > This path add support rv1108 and px30 rgb output interface driver.
> 
> Hi Sandy,
> Seems like you forgot to address Rob's comment regarding the "driver" word.
> Also fix the typo: s/path/patch
> The subject could be improved as well: s/devicetree\/bindings/dt-bindings

We actually honored Rob's bigger concern of the rgb output not being
an actual device backed by programmable hardware and moved the rgb
output inside the driver, see v7 of the patchset [0].


Heiko

[0] https://patchwork.freedesktop.org/patch/246297/
https://patchwork.freedesktop.org/patch/246298/
https://patchwork.freedesktop.org/patch/246299/
