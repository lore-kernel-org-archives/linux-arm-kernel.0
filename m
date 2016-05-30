From: yt.shen@mediatek.com (YT Shen)
Date: Mon, 30 May 2016 18:24:41 +0800
Subject: [RFC v2 2/5] drm/mediatke: add support for Mediatek SoC MT2701
In-Reply-To: <CACvgo51gUVtVZtanQh787YeB8F_WHsNx6b1Oi0iBAEYLWZtJMw@mail.gmail.com>
References: <1463756736-46573-1-git-send-email-yt.shen@mediatek.com>
 <1463756736-46573-3-git-send-email-yt.shen@mediatek.com>
 <CACvgo51gUVtVZtanQh787YeB8F_WHsNx6b1Oi0iBAEYLWZtJMw@mail.gmail.com>
Message-ID: <1464603881.21437.18.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Emil,
On Fri, 2016-05-27 at 10:35 +0100, Emil Velikov wrote:
> Hi YT Shen,
> 
> There's a typo in the commit summary - s/mediatke/mediatek/.
Ooops, even I type this word everyday, I still made a mistake...
> 
> On 20 May 2016 at 16:05,  <yt.shen@mediatek.com> wrote:
> > From: YT Shen <yt.shen@mediatek.com>
> >
> > This patch add support for the Mediatek MT2701 DISP subsystem.
> > There is only one OVL engine in MT2701.
> >
> As is you introduce a broken driver only to fix it up with patches 3/5
> and 4/5. You really want to have this patch as 4/5, with the MT2701
> hunks from 3/5 merged in here.
OK, I will reorder the patch series in the next version.
2/5: add *driver_data for hardware specific settings
3/5: add shadow register support
4/5: add support for Mediatek SoC MT2701

> 
> Regards,
> Emil
