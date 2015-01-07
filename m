From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 07 Jan 2015 12:28:13 +0100
Subject: [PATCH 3/4] arm64: dts: Add APM X-Gene PCIe DMA device tree nodes
In-Reply-To: <CAL-zptPDU2qoot-aZMDwRmPQ_4QoCsqtQZ=kc-fN-Ts68qrVDQ@mail.gmail.com>
References: <1420608537-12296-1-git-send-email-mchitale@apm.com>
 <6884775.IcL8KCPQhi@wuerfel>
 <CAL-zptPDU2qoot-aZMDwRmPQ_4QoCsqtQZ=kc-fN-Ts68qrVDQ@mail.gmail.com>
Message-ID: <3436854.9cvJACJGLE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 January 2015 16:15:54 Mayuresh Chitale wrote:
> Hi Arnd,
> 
> Actually the addresses are different. For e.g port 0 base address is
> 1F2B0000 and port 1 base address is 1F2C0000 and so on.
> 

Ah, I see now. Just change the name to 'dma' then.

	Arnd
