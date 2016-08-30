From: robh@kernel.org (Rob Herring)
Date: Tue, 30 Aug 2016 14:52:23 -0500
Subject: [PATCH v8 09/11] doc: bindings: mfd: act8945a: Update the example
In-Reply-To: <1472110715-22242-1-git-send-email-wenyou.yang@atmel.com>
References: <1472109599-21915-1-git-send-email-wenyou.yang@atmel.com>
 <1472110715-22242-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20160830195223.GA2824@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 25, 2016 at 03:38:35PM +0800, Wenyou Yang wrote:
> Since the act8945a-charger is regarded as a sub-device and it using
> "interrupts" property, update the examples section.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
> 
> Changes in v8: None
> Changes in v7: None
> Changes in v6: None
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None

Humm, appears to be a new patch to me.

> 
>  Documentation/devicetree/bindings/mfd/act8945a.txt | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
