From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 6 Apr 2012 11:35:20 +0800
Subject: [PATCH v8 4/4] ARM: mxs/mx28evk: add GPMI-NAND device
In-Reply-To: <C7A5B00EFC707A46AB67997D0215216701B5C28A@mx1.grid-net.com>
References: <1314169643-23425-1-git-send-email-b32955@freescale.com>
 <1314169643-23425-5-git-send-email-b32955@freescale.com>
 <CAOMZO5D_ACi73J0QfXoJmvyw6fBMrQfyoKLkK2P+-kMm5EzaDQ@mail.gmail.com>
 <20120405010829.GG7264@S2101-09.ap.freescale.net>
 <CAOMZO5ACk06aFWmmH0ZXCf6XoLaShwUaoAW0jHKmDTsJ0v027A@mail.gmail.com>
 <20120405012343.GH7264@S2101-09.ap.freescale.net>
 <CAOMZO5D2v4-ZoUXEhn7-Z7oSJ190egpkWGLkbaVzkjU5=HCNVA@mail.gmail.com>
 <20120406023121.GK7264@S2101-09.ap.freescale.net>
 <C7A5B00EFC707A46AB67997D0215216701B5C28A@mx1.grid-net.com>
Message-ID: <20120406033517.GL7264@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 05, 2012 at 08:08:52PM -0700, Subodh Nijsure wrote:
> 
> Hello Shawn,
> 
> You also have to consider that folks who are using MX28 based design might be just now shifting from freescale provided 2.6.35 SDK to the latest 3.4-rcX train on their own (my case). To make them wait for 3.5 to get all the iMX driver seems like hard thing to do.
>  
I'm pretty sure that even 3.5 will not have all the imx28 drivers
support.  Also freezing board file update does not block anyone adding
new driver support in any way.  I do not understand what your argument
is.

Please note, the gpmi nand mx28evk board patch was not accept because
it has pin confliction issue to be resolved.

-- 
Regards,
Shawn
