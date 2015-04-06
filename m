From: horms@verge.net.au (Simon Horman)
Date: Mon, 6 Apr 2015 09:23:54 +0900
Subject: [PATCH v2] ARM: shmobile: r8a7791: Remove MSIOF address from
 device tree
In-Reply-To: <CAMuHMdVH19ZncC0dMbO8-rCzN6MkOVWfiSKLDAnsqW6_Z_pw1Q@mail.gmail.com>
References: <1428166512-2936-1-git-send-email-ykaneko0929@gmail.com>
 <CAMuHMdVH19ZncC0dMbO8-rCzN6MkOVWfiSKLDAnsqW6_Z_pw1Q@mail.gmail.com>
Message-ID: <20150406002353.GB1841@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 05, 2015 at 10:47:01AM +0200, Geert Uytterhoeven wrote:
> On Sat, Apr 4, 2015 at 6:55 PM, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> > From: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
> >
> > MSIOF Base Address H'E6xx can be accessed by CPU and DMAC.
> > MSIOF Base Address H'E7xx for DMAC was removed from H/W manual.
> >
> > Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
> > Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up for v4.2.
