From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 05 Jan 2015 16:24:10 +0100
Subject: [PATCH V3 00/10] ARM: sirf: drop CSR marco and add atlas7 platform
In-Reply-To: <1420273664-10438-1-git-send-email-21cnbao@gmail.com>
References: <1420273664-10438-1-git-send-email-21cnbao@gmail.com>
Message-ID: <2479441.FXiT5krZaN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 03 January 2015 16:27:34 Barry Song wrote:
> From: Barry Song <Baohua.Song@csr.com>
> 
> this patchset drops MARCO as it is not supported any more. its 
> replacement is atlas7.
> some IPs from marco are moved to atlas7, for example timer. for this 
> kind of IPs, we rename to atlas7. some IPs need some change for 
> atlas7, such as platsmp, we break marco and move to atlas7 directly.
> 
> the patchset add debug ports, machine and devicetree for the new atlas7.

Looks good. Please send separate pull requests for DT, core and driver
bits, or send the patches for inclusion to arm at kernel.org so they don't
get lost.

	Arnd
