From: olof@lixom.net (Olof Johansson)
Date: Fri, 7 Jun 2013 18:27:54 -0700
Subject: [GIT PULL] ARM: imx: fixes for 3.10, take 2
In-Reply-To: <20130608012632.GA22134@S2101-09.ap.freescale.net>
References: <20130603150953.GA13853@S2101-09.ap.freescale.net>
 <20130608011913.GA27720@quad.lixom.net>
 <20130608012632.GA22134@S2101-09.ap.freescale.net>
Message-ID: <CAOesGMh=9hka7T5VKcrR4+WzfAY6ZE8tpYNnEM1VZg9w05Z7UA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 7, 2013 at 6:26 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Fri, Jun 07, 2013 at 06:19:13PM -0700, Olof Johansson wrote:
>> > - Two imx6q clock fixes, which correct axi_sels and ldb_di_sels.
>>
>> Are these regressions, or fixes for things that have never worked?
>
> I believe these are errors caught by the drivers that haven't hit
> mainline.

For this stage in the release cycle, they should wait for the next
release. I've done the pull now but please be more diligent about
fixing serious problems and regressions only after -rc3 or so.


-Olof
