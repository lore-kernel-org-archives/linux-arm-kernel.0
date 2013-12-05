From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 5 Dec 2013 08:00:28 +0000
Subject: Boot time errors/warnings on snowball
In-Reply-To: <20131204185947.GC29268@sirena.org.uk>
References: <CAOesGMgwyU-fJWkiF+78US+vVZ7Ensku-j+O1UPFVt43WDfUsA@mail.gmail.com>
 <CACRpkda3V4bK3_QO76=++Gcm3pJp78G2L3pgAdaJb2NDcAJG6Q@mail.gmail.com>
 <20131204172626.GB26581@lee--X1>
 <CAOesGMjMWqPtJXh7-VAhyA1a95h7mKV8_UZhyTtxgEbUhU8_5Q@mail.gmail.com>
 <20131204175119.GD26581@lee--X1>
 <CAOesGMh7+r9vUvtH_pwJeMyQJGo3u-uJRJ8-OBidzzO1pC5RDA@mail.gmail.com>
 <20131204185947.GC29268@sirena.org.uk>
Message-ID: <20131205080028.GG26581@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > We're usually fairly quick at merging our branches during the merge
> > window, so sequencing should be fine. Even if Mark does his pull
> > requests before us, the window of breakage should be minimal (and
> > we're now aware of it).
> 
> If there's a topic branch for the ARM side I can pull it into ASoC to
> get the window down to a few commits (or even rebase the ux500 stuff
> onto it to remove it).

If you're happy to rebase your asoc/topic/ux500 onto Linus'
ux500-devicetree-v3.14-1 tag, I believe that would solve the
dependency.

> Or I can sign the ux500 branch for arm-soc.

What does that do?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
