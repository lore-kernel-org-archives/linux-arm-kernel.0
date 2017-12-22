From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Fri, 22 Dec 2017 11:10:21 +0100
Subject: [PATCH v2 5/8] arm64: dts: actions: Add S700 and CubieBoard7
In-Reply-To: <20171113233427.5386-6-afaerber@suse.de>
References: <20171113233427.5386-1-afaerber@suse.de>
 <20171113233427.5386-6-afaerber@suse.de>
Message-ID: <e8319d48-44a7-104f-6266-862500d030e2@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 14.11.2017 um 00:34 schrieb Andreas F?rber:
> Add Device Trees for S700 SoC and Cubietech CubieBoard7.
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v1 -> v2: Unchanged
>  
>  arch/arm64/boot/dts/actions/Makefile             |   2 +
>  arch/arm64/boot/dts/actions/s700-cubieboard7.dts |  47 +++++++
>  arch/arm64/boot/dts/actions/s700.dtsi            | 164 +++++++++++++++++++++++
>  3 files changed, 213 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/actions/s700-cubieboard7.dts
>  create mode 100644 arch/arm64/boot/dts/actions/s700.dtsi

Squashed patch updated with new SPDX header style and applied:

https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git/log/?h=v4.16/dt64

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
