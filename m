From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 26 Apr 2013 16:19:48 +0100
Subject: [PATCH 00/10] usb: musb: ux500: pathe the way for Device Tree
 enablement
In-Reply-To: <20130426134915.GA19558@balto.lan>
References: <1366729394-11406-1-git-send-email-lee.jones@linaro.org>
 <20130426134915.GA19558@balto.lan>
Message-ID: <20130426151948.GE31899@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 26 Apr 2013, Fabio Baltieri wrote:

> Hi Lee,
> 
> On Tue, Apr 23, 2013 at 04:03:04PM +0100, Lee Jones wrote:
> > In this patch-set we firstly ease the burden on data being passed from
> > platform data, then start to build up support to finally enable Device
> > Tree.
> 
> The whole series looks good to me, nice job!!
> 
> Acked-by: Fabio Baltieri <fabio.baltieri@linaro.org>

Thanks for reviewing.

> I was not able to apply the patches though, as I can imagine that there
> are some dependencies with your other dma40 series.  If you can provide a
> tree I would be happy to run some test for both host and device mode.
> I still have a bunch of USB cables and adapters tangled together on my
> desk ready for that.

The most recent branch on my public tree contains the latest code.

Memcpy will probably fail though, as I haven't fixed up Linus'
comments pertaining them that yet.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
