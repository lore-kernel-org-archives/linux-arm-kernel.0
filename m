From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 6 Apr 2012 21:46:02 +0800
Subject: [PATCH v8 4/4] ARM: mxs/mx28evk: add GPMI-NAND device
In-Reply-To: <CAOMZO5Ab=cdOevjBhEyQtxVo3mEuoq7xy0auGinUoyh-TddTDw@mail.gmail.com>
References: <1314169643-23425-5-git-send-email-b32955@freescale.com>
 <CAOMZO5D_ACi73J0QfXoJmvyw6fBMrQfyoKLkK2P+-kMm5EzaDQ@mail.gmail.com>
 <20120405010829.GG7264@S2101-09.ap.freescale.net>
 <CAOMZO5ACk06aFWmmH0ZXCf6XoLaShwUaoAW0jHKmDTsJ0v027A@mail.gmail.com>
 <20120405012343.GH7264@S2101-09.ap.freescale.net>
 <CAOMZO5D2v4-ZoUXEhn7-Z7oSJ190egpkWGLkbaVzkjU5=HCNVA@mail.gmail.com>
 <20120406023121.GK7264@S2101-09.ap.freescale.net>
 <CAOMZO5Dr+qVMOpG6T03L-+i6qYkJRPUPT87hcJAs6DxHs+EcmA@mail.gmail.com>
 <20120406065302.GN7264@S2101-09.ap.freescale.net>
 <CAOMZO5Ab=cdOevjBhEyQtxVo3mEuoq7xy0auGinUoyh-TddTDw@mail.gmail.com>
Message-ID: <20120406134600.GQ7264@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 06, 2012 at 10:16:48AM -0300, Fabio Estevam wrote:
> On Fri, Apr 6, 2012 at 3:53 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
...
> > I could accept your spi board file patch when spi-mxs driver hit
> > mainline while mx28 dt does not.
> 
> Excellent, that's good news and we come to an agreement  :-) Thanks!

I'm pretty sure that imx28 dt patch from Dong Aisheng will hit mainline
with v3.5-rc1, which could be the earliest time for spi-mxs to hit
mainline.  In that case, I do not have any reason to take your board
file patch from there, so what's point of the while argument?

-- 
Regards,
Shawn
