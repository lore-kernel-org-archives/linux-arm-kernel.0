From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 13 Nov 2014 09:14:27 +0100
Subject: [PATCH 4/5] ARM: mvebu: adjust ethernet aliases according to
 U-Boot requirements for A38x
In-Reply-To: <1415835600-97188-5-git-send-email-mw@semihalf.com>
References: <1415835600-97188-1-git-send-email-mw@semihalf.com>
 <1415835600-97188-5-git-send-email-mw@semihalf.com>
Message-ID: <20141113091427.31113495@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Marcin Wojtas,

On Thu, 13 Nov 2014 00:39:59 +0100, Marcin Wojtas wrote:
> The vendor bootloader provided for Armada 38x boards expects an
> alias for the ethernet nodes, which is used to fixup the MAC address.
> The alias format naming is strict.

I believe this needs a bit more explanation: why would we care about
the "vendor bootloader" ? What are expecting the mainline versions of
popular bootloaders like U-Boot and Barebox ? What are other platforms
supported in the mainline doing ?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
