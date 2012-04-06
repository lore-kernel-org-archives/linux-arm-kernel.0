From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 6 Apr 2012 10:56:29 -0300
Subject: [PATCH v8 4/4] ARM: mxs/mx28evk: add GPMI-NAND device
In-Reply-To: <20120406134600.GQ7264@S2101-09.ap.freescale.net>
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
 <20120406134600.GQ7264@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5AZzaVWe+vU=JCOv3QQAfUTWRdNVDsaUx+9Q+O8N0J_EQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 6, 2012 at 10:46 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> I'm pretty sure that imx28 dt patch from Dong Aisheng will hit mainline
> with v3.5-rc1, which could be the earliest time for spi-mxs to hit
> mainline. ?In that case, I do not have any reason to take your board
> file patch from there, so what's point of the while argument?

Ok, will submit the mxs spi driver (non-dt aware) next week when I
come back to the office.

You can drop all of the arch mxs spi patches I sent you
