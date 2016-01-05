From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 05 Jan 2016 10:31:31 +0100
Subject: [PATCH v2 5/6] reset: mediatek: mt2701 reset controller
 dt-binding file
In-Reply-To: <1451975422-31174-6-git-send-email-jamesjj.liao@mediatek.com>
References: <1451975422-31174-1-git-send-email-jamesjj.liao@mediatek.com>
 <1451975422-31174-6-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <1451986291.3391.5.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 05.01.2016, 14:30 +0800 schrieb James Liao:
> From: Shunli Wang <shunli.wang@mediatek.com>
> 
> Dt-binding file about reset controller is used to provide
> kinds of definition, which is referenced by dts file and
> IC-specified reset controller driver code.
> 
> Signed-off-by: Shunli Wang <shunli.wang@mediatek.com>
> ---
>  .../dt-bindings/reset-controller/mt2701-resets.h   | 74 ++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 include/dt-bindings/reset-controller/mt2701-resets.h
> 
> diff --git a/include/dt-bindings/reset-controller/mt2701-resets.h b/include/dt-bindings/reset-controller/mt2701-resets.h

No new files in include/dt-bindings/reset-controller, please.
This should go into include/dt-bindings/reset.

regards
Philipp
