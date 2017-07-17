From: corbet@lwn.net (Jonathan Corbet)
Date: Mon, 17 Jul 2017 13:44:45 -0600
Subject: [PATCH resend] Documentation: arm: Replace use of virt_to_phys
 with __pa_symbol
In-Reply-To: <1500298768-13262-1-git-send-email-geert+renesas@glider.be>
References: <1500298768-13262-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170717134445.22a1b00d@lwn.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 17 Jul 2017 15:39:28 +0200
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> All low-level PM/SMP code using virt_to_phys() should actually use
> __pa_symbol() against kernel symbols.  Update the documentation to move
> away from virt_to_phys().
> 
> Cfr. commit 6996cbb2372189f7 ("ARM: 8641/1: treewide: Replace uses of
> virt_to_phys with __pa_symbol")

I was kind of hoping for an ack from somebody on this, but, four months
later, I'll take the absence of complaints as being enough.  Applied,
thanks.

jon
