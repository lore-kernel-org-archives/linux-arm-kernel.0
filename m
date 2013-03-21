From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Mar 2013 13:24:37 +0000
Subject: [PATCH 00/11] sp804 and integrator timer CLKSRC_OF support
In-Reply-To: <1363820051-24428-1-git-send-email-robherring2@gmail.com>
References: <1363820051-24428-1-git-send-email-robherring2@gmail.com>
Message-ID: <201303211324.37654.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 March 2013, Rob Herring wrote:
> This series is dependent on my CLKSRC_OF clean-up in arm-soc, my
> sched_clock selection series[1], and Arnd's default machine descriptor
> patch (for default clocksource_of_init call). The full series is
> available here:

All your patches look good to me, but I'd suggest you don't depend on
my default machine descriptor patch yet, that just makes the dependencies
harder to track, and we can easily remove all the calls once they
are obsoletely.

	Arnd
