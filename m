From: Marc.Dietrich@ap.physik.uni-giessen.de (Marc Dietrich)
Date: Wed, 31 Aug 2011 18:55:03 +0200
Subject: [PATCH] usb: ehci: make HC see up-to-date qh/qtd descriptor ASAP
In-Reply-To: <4E5E5D80.6080409@arm.com>
References: <1314720193-26577-1-git-send-email-ming.lei@canonical.com>
	<1314804471.2344.79.camel@deneb.redhat.com>
	<4E5E5D80.6080409@arm.com>
Message-ID: <201108311855.27711.marc.dietrich@ap.physik.uni-giessen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch 31 August 2011, 18:12:48 schrieb Marc Zyngier:
> [...]
> Oddly enough, this patch doesn't do anything on my Tegra setup. In both
> cases, I get around 17MB/s from a crap SD card plugged in a USB reader.
> 
> This leads me to suspect that this issue is very much OMAP4 specific.
> Can anyone verify this theory on other some A9 platforms?

That's odd. On my Tegra2 (on ac100) it boosts the transfer rate from 7 to 
17 MB/s. 

Marc
