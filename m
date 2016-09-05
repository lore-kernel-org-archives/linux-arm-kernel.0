From: horms@verge.net.au (Simon Horman)
Date: Mon, 5 Sep 2016 13:59:09 +0200
Subject: [PATCH] ARM: dts: r8a7794: fix PWM clock parent
In-Reply-To: <CAMuHMdVezsJ1q0A4TCdhfEEPtnyMeXGGZxRREQucy6kr2BO=EA@mail.gmail.com>
References: <1618499.8bcj8adpVO@wasted.cogentembedded.com>
 <1994467.CVFvpbaMyF@wasted.cogentembedded.com>
 <CAMuHMdVezsJ1q0A4TCdhfEEPtnyMeXGGZxRREQucy6kr2BO=EA@mail.gmail.com>
Message-ID: <20160905115906.GA24256@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 05, 2016 at 11:50:41AM +0200, Geert Uytterhoeven wrote:
> On Sun, Sep 4, 2016 at 9:55 PM, Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com> wrote:
> > When removing the non-existing thermal clock I forgot to remove its
> > parent from the node's "clocks" property  -- this led to a wrong PWM
> > clock's parent clock.
> >
> > Fixes: 2a29f9d6fea8 ("ARM: dts: r8a7794: add MSTP5 clocks")
> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up.
