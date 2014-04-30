From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 30 Apr 2014 15:29:22 +0100
Subject: [PATCH 02/10] mfd: vexpress: Convert custom func API to regmap
In-Reply-To: <1398867224.24255.22.camel@hornet>
References: <1398707877-22596-1-git-send-email-pawel.moll@arm.com>
 <1398707877-22596-3-git-send-email-pawel.moll@arm.com>
 <20140430135855.GO29462@lee--X1> <1398867224.24255.22.camel@hornet>
Message-ID: <20140430142922.GU29462@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > MFD diffstat looks great and the changes look sensible:
> >   Acked-by: Lee Jones <lee.jones@linaro.org>
> 
> Thanks!
> 
> > I guess someone will need to create a branch for us all to pull from.
> > I'm happy to do it if needs be.
> 
> I was thinking that, with enough acks (and I'm counting on one from you
> for "[PATCH 04/10] mfd: vexpress: Define the device as MFD cells" :-),

That won't happen right away - it's another 500+ line patch and
contary to popular believe I do have my own work to contend with too.

> merging the whole series (or at least patches 1-4 and 7-8) through
> arm-soc tree would be the simplest option. I have no problem with the
> independent bits (clk, clocksource, hwmon and the mfd/HBI change) going
> through appropriate subsystems.

I have no problem with that as long as one of the ARM-SoC guys can
provide a branch where the other subsystems can pull from.  If they
have no time, my offer still stands.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
