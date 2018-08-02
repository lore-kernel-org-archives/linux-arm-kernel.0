From: stu.hsieh@mediatek.com (Stu Hsieh)
Date: Thu, 2 Aug 2018 19:39:09 +0800
Subject: [PATCH v1 14/15] drm/mediatek: fixed the error value for add
 DSI1 in mutex
In-Reply-To: <1532495445.9280.22.camel@mtksdaap41>
References: <1532420235-22268-1-git-send-email-stu.hsieh@mediatek.com>
 <1532420235-22268-15-git-send-email-stu.hsieh@mediatek.com>
 <1532495445.9280.22.camel@mtksdaap41>
Message-ID: <1533209949.11190.63.camel@mtksdccf07>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, CK:

On Wed, 2018-07-25 at 13:10 +0800, CK Hu wrote:
> Hi, Stu:
> 
> 
> On Tue, 2018-07-24 at 16:17 +0800, Stu Hsieh wrote:
> > This patch fixed the error value for add DSI1 in mutex
> > 
> 
> English is not my mother language, but should it be 'fix' rather than
> 'fixed'?
> 
> Regards,
> CK
> 
OK

Regards,
Stu
> > Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > index 3239f22785fd..ac047fdb1a2b 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > @@ -437,7 +437,7 @@ void mtk_disp_mutex_add_comp(struct mtk_disp_mutex *mutex,
> >  		reg = MUTEX_SOF_DSI0;
> >  		break;
> >  	case DDP_COMPONENT_DSI1:
> > -		reg = MUTEX_SOF_DSI0;
> > +		reg = MUTEX_SOF_DSI1;
> >  		break;
> >  	case DDP_COMPONENT_DSI2:
> >  		reg = MUTEX_SOF_DSI2;
> 
> 
