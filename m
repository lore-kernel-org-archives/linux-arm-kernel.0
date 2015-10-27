From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 Oct 2015 22:43:25 +0100
Subject: [PATCH] ARM64: juno: add NOR flash to device tree
In-Reply-To: <20151027123334.GC3091@leverpostej>
References: <5624C31D.3070906@arm.com> <20151019102932.GB10678@leverpostej>
 <CACRpkdaGscb_ccbGuwccsRj_b1d6xoveiiZpw1a5eXon3PxAUA@mail.gmail.com>
 <20151019113904.GE10678@leverpostej>
 <CACRpkdb1XRSq3EERbiMwCnuV7Dtit2xGYRDBtQ9+odyXq6kM7A@mail.gmail.com>
 <20151020112026.GF10728@bivouac.eciton.net>
 <CAD0U-hKZM-A2N_Lpnzwkt0WmAi+kRR=UOEE4Vr2M-iTo9ikkOg@mail.gmail.com>
 <CACRpkdZ2Ydyzf9rHOgjZ_KhhxqFi_cK1-Jh47Fh+SP4YGjg_EA@mail.gmail.com>
 <562F6799.1060301@arm.com>
 <CACRpkdbpD+Kr01hDc7QnL4x_4=A_rnAO+G0CaMce8+5ns+bx2Q@mail.gmail.com>
 <20151027123334.GC3091@leverpostej>
Message-ID: <CACRpkdY6qOLvQruFz2NK1GOyd+ea+8fHuPgUaJJa=mDxQH8fog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 27, 2015 at 1:33 PM, Mark Rutland <mark.rutland@arm.com> wrote:

> For situations like these we typically have the node, but ensure that it
> has status = "disabled". That way the DT is safe by default, and FW can
> grant the OS the ability to use the hardware by replacing/removing the
> status property.

Fair enough, I suggested the same as it happens. Will repost
with this changed and a fat comment describing why.

Yours,
Linus Walleij
