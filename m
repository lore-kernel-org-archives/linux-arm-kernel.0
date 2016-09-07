From: ck.hu@mediatek.com (CK Hu)
Date: Wed, 7 Sep 2016 12:58:03 +0800
Subject: [PATCH v7 8/9] drm/mediatek: update DSI sub driver flow
In-Reply-To: <1472815484-43821-9-git-send-email-yt.shen@mediatek.com>
References: <1472815484-43821-1-git-send-email-yt.shen@mediatek.com>
 <1472815484-43821-9-git-send-email-yt.shen@mediatek.com>
Message-ID: <1473224283.11736.27.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, YT:

On Fri, 2016-09-02 at 19:24 +0800, YT Shen wrote:
> This patch update enable/disable flow of DSI module and MIPI TX module
> 
> Signed-off-by: shaoming chen <shaoming.chen@mediatek.com>
> Signed-off-by: YT Shen <yt.shen@mediatek.com>
> ---

I think the description is too simple. Please briefly describe WHY of
this patch. The original enable/disable flow is workable, so why do you
need this patch? Without this patch, what problem would happen?

Regards,
CK
