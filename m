From: tyler.baker@linaro.org (Tyler Baker)
Date: Thu, 16 Apr 2015 09:45:12 -0700
Subject: n900 in 4.1-rc0
In-Reply-To: <20150416093234.GA17423@amd>
References: <20150416093234.GA17423@amd>
Message-ID: <CANMBJr5G2RpS1sw3N8FYitqzqFu8a2Gqj__i_742FZrMYuusOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 April 2015 at 02:32, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
> Just tried booting 4.1-rc0 on n900 (commit
> 34c9a0ffc75ad25b6a60f61e27c4a4b1189b8085) and it is broken.
>
> Any ideas?

Looks like DT and legacy booting are working fine in our labs. [0][1]

>                                                                         Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Tyler

[0] http://kernelci.org/boot/omap3-n900/
[1] http://kernelci.org/boot/omap3-n900,legacy/
