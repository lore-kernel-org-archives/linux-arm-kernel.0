From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 Oct 2015 22:41:56 +0100
Subject: [PATCH] ARM64: juno: add NOR flash to device tree
In-Reply-To: <562F6EFF.2030404@arm.com>
References: <1444904415-19597-1-git-send-email-linus.walleij@linaro.org>
 <561FC681.2040809@arm.com>
 <CACRpkdaSox9WKb5-dkD_zAwO9WxP6+b010p3bdxsm1LRy=WvKg@mail.gmail.com>
 <5624C31D.3070906@arm.com> <20151019102932.GB10678@leverpostej>
 <CACRpkdaGscb_ccbGuwccsRj_b1d6xoveiiZpw1a5eXon3PxAUA@mail.gmail.com>
 <20151019113904.GE10678@leverpostej>
 <CACRpkdb1XRSq3EERbiMwCnuV7Dtit2xGYRDBtQ9+odyXq6kM7A@mail.gmail.com>
 <20151020112026.GF10728@bivouac.eciton.net>
 <CAD0U-hKZM-A2N_Lpnzwkt0WmAi+kRR=UOEE4Vr2M-iTo9ikkOg@mail.gmail.com>
 <CACRpkdZ2Ydyzf9rHOgjZ_KhhxqFi_cK1-Jh47Fh+SP4YGjg_EA@mail.gmail.com>
 <562F6799.1060301@arm.com>
 <CACRpkdbpD+Kr01hDc7QnL4x_4=A_rnAO+G0CaMce8+5ns+bx2Q@mail.gmail.com>
 <562F6EFF.2030404@arm.com>
Message-ID: <CACRpkdZisKfiC2w2ma3+ubUbY2-SBwFkOZeUU21fnC6AUF2SnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 27, 2015 at 1:33 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:

> OK, I agree with you on not hiding. But disabling it seems OK for me as
> it's a hardware errata(SROM can't be used and hence NOR is used in warm
> reset path)

OK then, what about:

status = "disabled";

With a comment explaining why?

Yours,
Linus Walleij
