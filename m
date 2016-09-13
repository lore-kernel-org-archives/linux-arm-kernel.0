From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Sep 2016 17:28:33 +0200
Subject: [PATCHv2] ARM: dts: explicitly mark skeleton.dtsi as deprecated
In-Reply-To: <1472834090-24528-1-git-send-email-mark.rutland@arm.com>
References: <1472834090-24528-1-git-send-email-mark.rutland@arm.com>
Message-ID: <2855680.gsrh9qO4OM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, September 2, 2016 5:34:50 PM CEST Mark Rutland wrote:
> As noted in commit 3ebee5a2e141496b ("arm64: dts: kill skeleton.dtsi"),
> there are a number of problems with skeleton.dtsi, and it would be
> prefereable to remove it entirely. As there are a large number of
> existing users, fixing these up will take a while.
> 
> This patch adds a note to arm's skeleton.dtsi noting that this is the
> case, to make this more obvious and hopefully minimize new uptake of
> skeleton.dtsi in the mean time.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>
> ---
>  arch/arm/boot/dts/skeleton.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> Arnd, Olof, could you please pick this up?
> 
> 

Applied to next/dt, thanks!

	Arnd
