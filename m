From: vince@kyllikki.org (Vincent Sanders)
Date: Fri, 4 Jun 2010 23:28:20 +0100
Subject: defconfig information
Message-ID: <20100604222820.GA4438@kyllikki.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With all the recent issues over default configurations I have decided
to release the Kernel autobuilder fifth anniversary statistics a bit
early.

http://armlinux.simtec.co.uk/reports/kautobuild-5year-report.pdf
http://armlinux.simtec.co.uk/reports/kautobuild-5year-stats.ods

The report is still a little raw but clearly illustrates the
proliferation of default configurations on ARM (although MIPS and PPC
are not all that far behind!) 

In brief, we could loose around 90% of the default configurations
(i.e. keep only 20 configurations) and "only" loose build coverage of
40% of the supported machines!

As always the ARM Kernel autobuilder is available at
http://armlinux.simtec.co.uk/kautobuild/ 

The community usage of this service has dropped to an all time low
(only six people actually used it in the last month) and I am
seriously considering if it serves a useful purpose any longer.

-- 
Regards Vincent
