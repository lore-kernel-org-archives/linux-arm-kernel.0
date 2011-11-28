From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Mon, 28 Nov 2011 23:30:45 +0100
Subject: [PATCH 4/5] init/calibrate.c: allow for recalibration of loops
 per jiffy
In-Reply-To: <20111128153900.GA16481@n2100.arm.linux.org.uk>
References: <1322364751-29980-1-git-send-email-jkrzyszt@tis.icnet.pl>
 <1322364751-29980-5-git-send-email-jkrzyszt@tis.icnet.pl>
 <20111128153900.GA16481@n2100.arm.linux.org.uk>
Message-ID: <201111282330.46015.jkrzyszt@tis.icnet.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 of November 2011 at 16:39:00, Russell King - ARM Linux wrote:
> On Sun, Nov 27, 2011 at 04:32:30AM +0100, Janusz Krzysztofik wrote:
> > This is required on ARM OMAP1 platform, after DPLL reprogramming has
> > been fixed by moving it from setup_arch() to kernel_init().
> > 
> > Created against linux-3.2-rc2.
> 
> Why do you need this?  If you know what the original CPU clock rate and
> bogomips were, and the new CPU clock rate, then you simply scale the
> bogomips from the original accordingly.  That's what cpufreq does.

Hi,
Please ignore this patch. I'm going to post a replacement for patch 5/5 
which, thanks to Russell's help, will no longer require any changes in 
init/calibrate.c.

Russell,
Thanks for pointing me into the right direction.

Janusz
