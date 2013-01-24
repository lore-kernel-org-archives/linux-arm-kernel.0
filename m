From: olof@lixom.net (Olof Johansson)
Date: Thu, 24 Jan 2013 08:32:51 -0800
Subject: [GIT PULL] vexpress: fixes for v3.8-rc5
In-Reply-To: <1359031777.26878.49.camel@hornet>
References: <1359031777.26878.49.camel@hornet>
Message-ID: <CAOesGMhGUzKoqjQLkiQLR7UNeAhWv0KNeLwtpC9uPWreeQ97hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 24, 2013 at 4:49 AM, Pawel Moll <pawel.moll@arm.com> wrote:
> Hi Arnd, Olof,
>
> Could you, please, pull this small series of VE fixes for v3.8-rc5? It:
>
> * makes the V2P-CA15_A7 (a.k.a. TC2) work with 3.8 kernels
> * improves vexpress-sysreg.c behaviour on arm64 platforms
>
> Thanks!
>
> Pawel
>
> The following changes since commit 7d1f9aeff1ee4a20b1aeb377dd0f579fe9647619:
>
>   Linux 3.8-rc4 (2013-01-17 19:25:45 -0800)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/pawelmoll/linux.git vexpress/fixes

Pulled. Thanks for giving an overview of the contents. If you have a
chance, please explore using signed tags to hold that contents too,
since it makes life even easier for us doing the pulls. :-)


-Olof
