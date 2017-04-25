From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 25 Apr 2017 14:26:10 -0300
Subject: [PATCH] ARM: dts: imx6sx-sdb: Remove cpufreq OPP override
In-Reply-To: <1493141004.3557.8.camel@nxp.com>
References: <89cc7192100bdc9ce546bf6000446e629457ebc1.1493138693.git.leonard.crestez@nxp.com>
 <CAOMZO5BsgXRfgZ0hszk2Vgo2keVDHH1BLbJTbW+awMS2cBoNow@mail.gmail.com>
 <CAOMZO5CKUsEr1yf5RrsPLipNtLC_6sK0dPjT2M-eN-uo8hEbrQ@mail.gmail.com>
 <1493141004.3557.8.camel@nxp.com>
Message-ID: <CAOMZO5DRhyRrwRoAVjd3uW6MgSUQ_k4gu8ZNQvMEh+0EcskVUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 25, 2017 at 2:23 PM, Leonard Crestez
<leonard.crestez@nxp.com> wrote:

> Wow, that was literally 15 minutes before my patch. In my defense I did
> search the archives before starting to format the patch but it had not
> arrived yet.
>
> Anyway, that version also sets the supply for reg_arm and reg_soc. It
> is not necessary for fixing the crash I'm seeing but is good because it
> will result in the minimum voltage on VDD_ARM_SOC_IN rather than a fix
> 1375mv. I tested Marek's patch and it works fine on my rev B board
> (which otherwise fails to boot upstream).

Excellent! I only have revA board and do not get the crash with this revision.

If you can reply to Marek's patch with your Tested-by that would be
nice, thanks.
