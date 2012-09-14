From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 14 Sep 2012 10:37:18 +0100
Subject: [PATCH 01/19] ARM: ux500: Add skeleton Device Tree for the HREF
 reference board
In-Reply-To: <CACRpkdbWVjiqrehj_v7M=cgnytEio5whTXOcax5wo0YSRe=-yA@mail.gmail.com>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <1347016499-29354-2-git-send-email-lee.jones@linaro.org>
 <CACRpkdbWVjiqrehj_v7M=cgnytEio5whTXOcax5wo0YSRe=-yA@mail.gmail.com>
Message-ID: <20120914093715.GM3374@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2012 at 01:47:09AM -0700, Linus Walleij wrote:
> On Fri, Sep 7, 2012 at 1:14 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > First commit applying the new Device Tree for ST-Ericsson's u8500
> > based hardware reference board.
> >
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> > +/dts-v1/;
> > +/include/ "dbx5x0.dtsi"
> 
> This include is not even in linux-next, is this patch series dependent
> on some other series I have not seen, or that I have forgot that
> I saw (and even possibly ACKed...)

Yes, all of the above.

I have them all here locally. Will test push something today hopefully.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
