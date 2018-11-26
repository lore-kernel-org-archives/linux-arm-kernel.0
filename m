From: a.hajda@samsung.com (Andrzej Hajda)
Date: Mon, 26 Nov 2018 07:58:43 +0100
Subject: [PATCH] drm/mediatek: Only try to attach bridge if there is one
In-Reply-To: <20181126040737.138682-1-drinkcat@chromium.org>
References: <CGME20181126041445epcas4p1f0db29e800181de3971f08f6939eec51@epcas4p1.samsung.com>
 <20181126040737.138682-1-drinkcat@chromium.org>
Message-ID: <6be0a453-80fb-4d97-1610-e4db124faf61@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26.11.2018 05:07, Nicolas Boichat wrote:
> Even if dsi->bridge is NULL, we still try to call drm_bridge_attach,
> and print out an error message, before creating the connector.
>
> When no bridge is provided, let's skip these 2 steps and directly
> create the connector.
>
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>


?--

Regards
Andrzej
