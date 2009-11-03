From: stefan@datenfreihafen.org (Stefan Schmidt)
Date: Tue, 3 Nov 2009 18:44:30 +0100
Subject: [PATCH 0/3] ezx: A780/A910 camera, A910 leds, ezx_defconfig update
In-Reply-To: <1257266734-28673-1-git-send-email-ospite@studenti.unina.it>
References: <1257266734-28673-1-git-send-email-ospite@studenti.unina.it>
Message-ID: <20091103174430.GA20822@excalibur.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

[Put Eric in CC]

On Tue, 2009-11-03 at 17:45, Antonio Ospite wrote:
> 
> some updates for the EZX platform:

Thanks for driving this forward.

> [PATCH 1/3] ezx: Add camera support for A780 and A910 EZX phones
> [PATCH 2/3] ezx: Add leds-lp3944 support for A910 EZX phone
> [PATCH 3/3] ezx: Update ezx_defconfig now that ezx-pcap is in
> 
> Are we still in time for 2.6.32?

Given that we are near -rc6 and this is clearly no fix I would say no. But Eric
should be happy to apply it to his devel branch which will hit Linus tree during
the next merge window.

Eric, Antonio is doing a good deal of the current work at OpenEZX. If you need
an ACK anyway you can put mine into it.

Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>

regards
Stefan Schmidt
