From: joro@8bytes.org (Joerg Roedel)
Date: Fri, 4 Aug 2017 11:44:49 +0200
Subject: [PATCH v2] memory: mtk-smi: Use of_device_get_match_data helper
In-Reply-To: <1501639370.5572.8.camel@mtksdaap41>
References: <1501072660-10435-1-git-send-email-honghui.zhang@mediatek.com>
 <1501639370.5572.8.camel@mtksdaap41>
Message-ID: <20170804094448.GB30515@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 02, 2017 at 10:02:50AM +0800, Honghui Zhang wrote:
> On Wed, 2017-07-26 at 20:37 +0800, honghui.zhang at mediatek.com wrote:
> > From: Honghui Zhang <honghui.zhang@mediatek.com>
> > 
> > Replace custom code with generic helper to retrieve driver data.
> 
> Hi, Joerg, would you please take this one, because my last
> patch[1]([patch v2 0/3] Add larbid init routine for mediatek's gen1 smi
> larb driver) was base on this patch. Or should I put this one together
> with the last patchset[1] and resend it with Matthias's reviewed-by
> tag[2]?

Yes, please send everything together. That makes it more easy for me to
apply it.


Thanks,

	Joerg
