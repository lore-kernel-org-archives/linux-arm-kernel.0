From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Fri, 22 Sep 2017 19:59:08 +0800
Subject: [PATCH v2] mmc: dt-bindings: Add reg/source_cg/latch-ck for
 Mediatek MMC bindings
In-Reply-To: <CACRpkdaco5XnWK-gAdGLWFZtjqnM16iT424ist5Zmd3RyAXAEQ@mail.gmail.com>
References: <1505958774-14410-1-git-send-email-chaotian.jing@mediatek.com>
 <CACRpkdaco5XnWK-gAdGLWFZtjqnM16iT424ist5Zmd3RyAXAEQ@mail.gmail.com>
Message-ID: <1506081548.28930.1.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-09-22 at 13:25 +0200, Linus Walleij wrote:
> On Thu, Sep 21, 2017 at 3:52 AM, Chaotian Jing
> <chaotian.jing@mediatek.com> wrote:
> 
> > +- mediatek,latch-ck: Some projects do not support enhance_rx, need set correct latch-ck to avoid data crc
> > +                    error caused by stop clock(fifo full)
> 
> I think I wrote elsewhere: replace "projects" with "systems" or "SoCs".

Sorry about that, will change to SoCs at v3.
> 
> Yours,
> Linus Walleij
