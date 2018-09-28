From: a.hajda@samsung.com (Andrzej Hajda)
Date: Fri, 28 Sep 2018 10:09:01 +0200
Subject: [PATCH v5 1/6] drm/bridge: dw-hdmi: allow forcing vendor phy-type
In-Reply-To: <20180912124740.20343-2-heiko@sntech.de>
References: <20180912124740.20343-1-heiko@sntech.de>
 <CGME20180912124755epcas3p399342e0ed3f9af94fbb1d9dfc01cb87a@epcas3p3.samsung.com>
 <20180912124740.20343-2-heiko@sntech.de>
Message-ID: <20180928080903eucas1p28f3f52d729fc2ee23d0ef7eb11c8d09b~YgfDFlQQD0996609966eucas1p2B@eucas1p2.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12.09.2018 14:47, Heiko Stuebner wrote:
> In some IP implementations the reading of the phy-type may be broken.
> One example are the Rockchip rk3228 and rk3328 socs that use a separate
> vendor-type phy from Innosilicon but still report the HDMI20_TX type.
>
> So allow the glue driver to force the vendor-phy for these cases.
> In the future it may be necessary to allow forcing other types, but
> for now we'll keep it simply to the case actually seen in the wild.
>
> changes in v3:
> - only allow forcing vendor type, as suggested by Laurent
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

?--
Regards
Andrzej
