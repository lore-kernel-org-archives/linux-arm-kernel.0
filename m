From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 04 Oct 2013 12:35:45 -0700
Subject: [PATCH] clk: palmas: add clock driver for palmas
In-Reply-To: <20131004164139.GR27287@sirena.org.uk>
References: <1380803407-15196-1-git-send-email-ldewangan@nvidia.com>
 <20131004164139.GR27287@sirena.org.uk>
Message-ID: <20131004193545.4343.15596@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Mark Brown (2013-10-04 09:41:39)
> On Thu, Oct 03, 2013 at 06:00:07PM +0530, Laxman Dewangan wrote:
> 
> > +     Optional subnode properties:
> > +     ti,clock-boot-enable: Enable clock at the time of booting.
> 
> Shouldn't this be a generic clock subsystem thing?  It seems like
> something that might be desired for nearly any clock.

The best solution is to have a driver claim the clock with clk_get and
enable it with clk_prepare_enable. I gave more detail in my reply to
Laxman.

Regards,
Mike
