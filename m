From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 3 Aug 2016 19:06:37 +0100
Subject: [PATCH 4/8] ARM: head.S: use PC-relative insn sequence for
 secondary_data
In-Reply-To: <1470238730-30038-5-git-send-email-ard.biesheuvel@linaro.org>
References: <1470238730-30038-1-git-send-email-ard.biesheuvel@linaro.org>
 <1470238730-30038-5-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160803180637.GJ1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 03, 2016 at 05:38:46PM +0200, Ard Biesheuvel wrote:
> Replace the open coded PC relative offset calculations with adr_l
> and ldr_l invocations.

.. and making it less efficient by doing so.  No thanks, I prefer the
original.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
