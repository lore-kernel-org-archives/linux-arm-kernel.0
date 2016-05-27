From: emil.l.velikov@gmail.com (Emil Velikov)
Date: Fri, 27 May 2016 10:35:20 +0100
Subject: [RFC v2 2/5] drm/mediatke: add support for Mediatek SoC MT2701
In-Reply-To: <1463756736-46573-3-git-send-email-yt.shen@mediatek.com>
References: <1463756736-46573-1-git-send-email-yt.shen@mediatek.com>
 <1463756736-46573-3-git-send-email-yt.shen@mediatek.com>
Message-ID: <CACvgo51gUVtVZtanQh787YeB8F_WHsNx6b1Oi0iBAEYLWZtJMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi YT Shen,

There's a typo in the commit summary - s/mediatke/mediatek/.

On 20 May 2016 at 16:05,  <yt.shen@mediatek.com> wrote:
> From: YT Shen <yt.shen@mediatek.com>
>
> This patch add support for the Mediatek MT2701 DISP subsystem.
> There is only one OVL engine in MT2701.
>
As is you introduce a broken driver only to fix it up with patches 3/5
and 4/5. You really want to have this patch as 4/5, with the MT2701
hunks from 3/5 merged in here.

Regards,
Emil
