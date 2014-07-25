From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Fri, 25 Jul 2014 10:45:53 +0200
Subject: [PATCH] ARM: at91: at91sam9x5: sets NPCS0 (PA14) back to GPIO
In-Reply-To: <53D214E1.4050105@aksignal.cz>
References: <1405074175-22444-1-git-send-email-voice.shen@atmel.com>
 <53D10C50.50305@aksignal.cz> <20140724162645.4e19c26c@bbrezillon>
 <53D12103.3020103@aksignal.cz> <20140724175848.44f5da10@bbrezillon>
 <53D1F5D0.1080006@aksignal.cz> <20140725095319.16a8465c@bbrezillon>
 <53D214E1.4050105@aksignal.cz>
Message-ID: <20140725104553.403921b1@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 25 Jul 2014 10:27:13 +0200
Ji?? Prchal <jiri.prchal@aksignal.cz> wrote:

[...]
> 
> 
> > Could you also paste the content of /sys/kernel/debug/gpio ?
> The /sys/kernel/debug/ is empty.

You have to enable CONFIG_DEBUG_FS in your config and then mount the
debug file system:

#mount -t debugfs dbg /sys/kernel/debug




-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
