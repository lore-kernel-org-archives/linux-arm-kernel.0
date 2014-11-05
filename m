From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 05 Nov 2014 21:30:30 +0100
Subject: [PATCH v7 3/3] ARM: dts: rk3288: add VOP iommu nodes
In-Reply-To: <1414983209-2472-4-git-send-email-djkurtz@chromium.org>
References: <1414983209-2472-1-git-send-email-djkurtz@chromium.org>
 <1414983209-2472-4-git-send-email-djkurtz@chromium.org>
Message-ID: <1838591.iyIlAuCyiq@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 3. November 2014, 10:53:29 schrieb Daniel Kurtz:
> Add device nodes for the VOP iommus.
> Device nodes for other iommus will be added in later patches.
> 
> The iommu nodes use the #iommu-cells property as described in:
>   Documentation/devicetree/bindings/iommu/iommu.txt
> 
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> Signed-off-by: Simon Xue <xxm@rock-chips.com>

I've applied this patch to my dts branch for 3.19
