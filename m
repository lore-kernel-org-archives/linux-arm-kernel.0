From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 4 Jun 2014 08:36:31 +0200
Subject: [PATCH] ARM: mvebu: DT: fix OpenBlocks AX3-4 RAM size
In-Reply-To: <CAGa+x84ZdQDtpdrxVPY2i9jnvZfug6JnP6Ok=5Tafqy3cbOtdw@mail.gmail.com>
References: <5388ddb9.0458440a.2be7.323c@mx.google.com>
 <1401818320-7202-1-git-send-email-jason@lakedaemon.net>
 <7hzjhtuasd.fsf@paris.lan>
 <CAGa+x84ZdQDtpdrxVPY2i9jnvZfug6JnP6Ok=5Tafqy3cbOtdw@mail.gmail.com>
Message-ID: <20140604083631.29959462@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Kevin Hilman,

On Tue, 3 Jun 2014 15:15:16 -0700, Kevin Hilman wrote:

> Also FYI, I put a temporary hack into my automated boot setup to use
> fdtput to live-patch the openblocks DTB with 1G, and you can see that
> openblocks is now passing boot test for big-endian:
> 
>    http://lists.linaro.org/pipermail/kernel-build-reports/2014-June/003812.html
> 
> Also FYI, I added mvebu_v7_defconfig + CONFIG_CPU_BIG_ENDIAN=y to the
> mix, so those should start showing up in subsequent boot tests also.

Great, thanks a lot for working on adding big endian testing to your
board farm. This is definitely going to be very useful!

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
