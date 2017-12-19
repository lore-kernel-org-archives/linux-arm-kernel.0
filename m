From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Dec 2017 23:16:44 +0000
Subject: [PATCH 6/9] ARM: init: update secondary_data register
 documentation
In-Reply-To: <a6e5e735ebae32a433e501188a86082efc8b0b52.1500510157.git.mirq-linux@rere.qmqm.pl>
References: <cover.1500510157.git.mirq-linux@rere.qmqm.pl>
 <a6e5e735ebae32a433e501188a86082efc8b0b52.1500510157.git.mirq-linux@rere.qmqm.pl>
Message-ID: <20171219231644.GG10595@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 20, 2017 at 02:29:25AM +0200, Micha? Miros?aw wrote:
> Fix secondary_data pointer register and document other
> occurrences in SMP boot code.
> 
> Signed-off-by: Micha? Miros?aw <mirq-linux@rere.qmqm.pl>

It's probably worth referecing commit 34d926266500 ("[ARM] Fix SMP booting")
since we have it in our history for this.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
