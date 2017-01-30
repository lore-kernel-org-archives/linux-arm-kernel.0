From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Jan 2017 16:26:28 +0000
Subject: [PATCH] arm: module: handle negative R_ARM_PREL31 addends
 correctly
In-Reply-To: <CAKv+Gu-0J0tVUUDhJ_f1P9n-1Etgk5A6ZTgUokKu7RKOCeaW4g@mail.gmail.com>
References: <1484907663-32322-1-git-send-email-ard.biesheuvel@linaro.org>
 <20170130123914.GQ27312@n2100.armlinux.org.uk>
 <CAKv+Gu-0J0tVUUDhJ_f1P9n-1Etgk5A6ZTgUokKu7RKOCeaW4g@mail.gmail.com>
Message-ID: <20170130162628.GD27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2017 at 03:08:56PM +0000, Ard Biesheuvel wrote:
> Actually, I think it may still be incorrect: it seems to me that we
> should preserve bit 31 rather than clear it. From the EHABI

Agreed.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
