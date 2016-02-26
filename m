From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Feb 2016 23:02:21 +0100
Subject: [PATCH 0/7] arm/arm64: Alpine patches for 4.6
In-Reply-To: <1456395297-6505-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1456395297-6505-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <2955978.E8qlghcpm8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 February 2016 11:14:50 Antoine Tenart wrote:
> Hi Arnd, Olof and Kevin,
> 
> Here are the Alpine patches for 4.6. As seen with Olof these patches are
> sent to you as a series as there are only 7 of them. I'll get my gpg key
> signed and setup a git tree somewhere for next time.
> 
> The first 3 patches introduce a basic arm64 Alpine support, by adding
> the Alpine v2 EVP board. The last 4 patches add an MSIX node in both
> Alpine v1 (arm) and Alpine v2 (arm64) dtsi and select the Alpine MSI
> controller driver.

Applied the patches to the next/dt, next/dt64, next/arm64 and next/soc
branches, respectively. I did not see any strong dependencies between
the patches, so they are now out of order (depending how Linus
pulls our branches). Please check if that's ok and if I missed anything.

They should show up in the for-next branch of arm-soc once I've done
some basic testing tonight.

	Arnd
