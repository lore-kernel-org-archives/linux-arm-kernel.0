From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 10 Nov 2015 18:15:49 -0800
Subject: [PATCH 00/10] ARM MTD AFS v2 partition support
In-Reply-To: <1444914533-27782-1-git-send-email-linus.walleij@linaro.org>
References: <1444914533-27782-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20151111021549.GV12143@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Thu, Oct 15, 2015 at 03:08:43PM +0200, Linus Walleij wrote:
> Years ago, the ARM reference platforms moved away from the footer
> format parsed by the current AFS code in MTD. As far as I can
> tell this begun with the RealView reference designs (mach-realview)
> and the new format has been used in RealView, Versatile Express
> and recently the Juno Development platform (64bit).
> 
> The code has not been working for newer designs for a long time.
> Proper parsing of the flash image partitions is very helpful when
> you want to replace firmware when running full Linux and none of
> the boot monitors or boot loaders.
> 
> After this, AFS parsing will work on all ARM reference designs,
> or well, all I could test. I tested the Integrator/AP, RealView
> PB11MPCore and Juno Development Platform.
> 
> The first 9 patches basically refactors the current code to
> make the old partition format more encapsulated, while the last
> patch adds the new v2 format.

Pushed the first 4 to l2-mtd.git/next (for 4.5). I'll move them to
/master when the merge window closes.

I'm reviewing the rest, but I have some comments on patch 5.

Also, do you have a pointer that documents the v2 format? I can probably
find something myself, but I'm a bit lazy, and if you have something
easy to point me to, that'd save me some time :)

Regards,
Brian
