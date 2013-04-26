From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Fri, 26 Apr 2013 15:49:15 +0200
Subject: [PATCH 00/10] usb: musb: ux500: pathe the way for Device Tree
 enablement
In-Reply-To: <1366729394-11406-1-git-send-email-lee.jones@linaro.org>
References: <1366729394-11406-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20130426134915.GA19558@balto.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Tue, Apr 23, 2013 at 04:03:04PM +0100, Lee Jones wrote:
> In this patch-set we firstly ease the burden on data being passed from
> platform data, then start to build up support to finally enable Device
> Tree.

The whole series looks good to me, nice job!!

Acked-by: Fabio Baltieri <fabio.baltieri@linaro.org>

I was not able to apply the patches though, as I can imagine that there
are some dependencies with your other dma40 series.  If you can provide a
tree I would be happy to run some test for both host and device mode.
I still have a bunch of USB cables and adapters tangled together on my
desk ready for that.

Fabio

-- 
Fabio Baltieri
