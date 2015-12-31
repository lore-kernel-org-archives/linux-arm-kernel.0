From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 31 Dec 2015 16:51:59 +0100
Subject: [GIT PULL] arm64: DTS fixes for X-Gene platforms for v4.5
In-Reply-To: <CADaLNDnwz-gyzN-1bzyGxAWL-5Jt2zSc_hvYQ2TpExGLC=Df3A@mail.gmail.com>
References: <CADaLNDnwz-gyzN-1bzyGxAWL-5Jt2zSc_hvYQ2TpExGLC=Df3A@mail.gmail.com>
Message-ID: <2734316.CUGyZXSbzW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 30 December 2015 16:09:46 Duc Dang wrote:
> Fixes for X-Gene DTS for v4.5
> 
> This patch set fixes the node names of X-Gene I2C, GPIO
> controller DT nodes; and also removes I2C clock nodes as
> the same clock is shared between 2 I2C controllers
> on X-Gene SoC.
> 
> 

Thanks a lot for the follow-up!

Merged into next/dt64 now.

	Arnd
