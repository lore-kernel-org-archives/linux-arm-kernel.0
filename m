From: tony@atomide.com (Tony Lindgren)
Date: Fri, 17 Jun 2016 02:39:45 -0700
Subject: [PATCH] arm: omap1: fix ams-delta FIQ handler to work with
 sparse IRQ
In-Reply-To: <1466106990-9556-1-git-send-email-jmkrzyszt@gmail.com>
References: <1466106990-9556-1-git-send-email-jmkrzyszt@gmail.com>
Message-ID: <20160617093944.GB22406@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Janusz Krzysztofik <jmkrzyszt@gmail.com> [160616 13:00]:
> After OMAP1 IRQ definitions have been changed by commit 685e2d08c54b
> ("ARM: OMAP1: Change interrupt numbering for sparse IRQ") introduced
> in v4.2, ams-delta FIQ handler which depends on them no longer works
> as expected. Fix it.

Applying into omap-for-v4.7/fixes thanks. Good to hear you got it
working, I recall being a bit worried about what all I might break
with the sparse IRQ conversion.. Sorry about that.

Regards,

Tony
