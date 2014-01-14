From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 13 Jan 2014 19:53:00 -0500
Subject: ARM: mvebu: dt: add missing alias 'eth3' on Armada XP mv78260
In-Reply-To: <20140112120924.GA1916@1wt.eu>
References: <20140112120924.GA1916@1wt.eu>
Message-ID: <20140114005300.GJ19878@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 12, 2014 at 01:09:24PM +0100, Willy Tarreau wrote:
> It was correctly set on mv78460 but not on mv78260, resulting in my
> OpenBlocks AX3-4 retrieving only 3 of its 4 MAC addresses from the
> boot loader.
> 
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Signed-off-by: Willy Tarreau <w@1wt.eu>
> ---
>  arch/arm/boot/dts/armada-xp-mv78260.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to mvebu/dt-fixes

thx,

Jason.
