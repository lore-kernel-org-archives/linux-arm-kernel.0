From: tony@atomide.com (Tony Lindgren)
Date: Wed, 9 Oct 2013 13:51:27 -0700
Subject: [GIT PULL] omap fixes against v3.12-rc3
In-Reply-To: <87d2netbvh.fsf@linaro.org>
References: <20131008220324.GV8313@atomide.com>
 <87d2netbvh.fsf@linaro.org>
Message-ID: <20131009205127.GF8313@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@linaro.org> [131009 13:50]:
> 
> FWIW, my automated boot is doing only DT boots on all the OMAP
> platforms.  However, it's only testing basic boot so far so there's not
> a whole lot of driver testing yet (but it's coming soon.)

OK cool. For omap3, off-idle with DT needs the pending
pinctrl-single patches, and some yet unknown way of mapping
wake-up events to device interrupts. But after that you
can also do some PM related tests potentially :)

Tony
