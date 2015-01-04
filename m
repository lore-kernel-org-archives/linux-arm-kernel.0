From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 04 Jan 2015 17:56:11 +0100
Subject: [PATCH V2 0/9] ARM: sirf: drop CSR marco and add atlas7 platform
In-Reply-To: <1420249007-8262-1-git-send-email-21cnbao@gmail.com>
References: <1420249007-8262-1-git-send-email-21cnbao@gmail.com>
Message-ID: <3309819.CeluCPZVf1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 03 January 2015 09:36:38 Barry Song wrote:
> From: Barry Song <Baohua.Song@csr.com>
> 
> this patchset drops MARCO as it is not supported any more. its replacement
> is atlas7.
> some IPs from marco are moved to atlas7, for example timer. for this kind
> of IPs, we rename to atlas7. some IPs need some change for atlas7, such as
> platsmp, we break marco and move to atlas7 directly.
> 
> the patchset add debug ports, machine and devicetree for the new atlas7.
> 

Looks all good, please add my

Acked-by: Arnd Bergmann <arnd@arndb.de>
