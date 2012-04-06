From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 6 Apr 2012 10:31:26 +0800
Subject: [PATCH v8 4/4] ARM: mxs/mx28evk: add GPMI-NAND device
In-Reply-To: <CAOMZO5D2v4-ZoUXEhn7-Z7oSJ190egpkWGLkbaVzkjU5=HCNVA@mail.gmail.com>
References: <1314169643-23425-1-git-send-email-b32955@freescale.com>
 <1314169643-23425-5-git-send-email-b32955@freescale.com>
 <CAOMZO5D_ACi73J0QfXoJmvyw6fBMrQfyoKLkK2P+-kMm5EzaDQ@mail.gmail.com>
 <20120405010829.GG7264@S2101-09.ap.freescale.net>
 <CAOMZO5ACk06aFWmmH0ZXCf6XoLaShwUaoAW0jHKmDTsJ0v027A@mail.gmail.com>
 <20120405012343.GH7264@S2101-09.ap.freescale.net>
 <CAOMZO5D2v4-ZoUXEhn7-Z7oSJ190egpkWGLkbaVzkjU5=HCNVA@mail.gmail.com>
Message-ID: <20120406023121.GK7264@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 05, 2012 at 01:12:03PM -0300, Fabio Estevam wrote:
...
> However, I think it is a bit early to block acceptance of non-DT code
> for mxs especially because there is no mx28 nor mx28evk in mainline
> yet.

I have to do that to motivate people to add DT support for the drivers
they submit from the beginning.

Also I do not see much point to keep patching board files which are
to be removed.

-- 
Regards,
Shawn
