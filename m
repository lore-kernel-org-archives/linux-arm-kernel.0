From: olof@lixom.net (Olof Johansson)
Date: Mon, 21 Jan 2013 23:21:56 -0800
Subject: [PATCH] dts: vt8500: Add initial dts support for WM8850
In-Reply-To: <1358577868-29042-1-git-send-email-linux@prisktech.co.nz>
References: <1358577868-29042-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <20130122072156.GC25783@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 19, 2013 at 07:44:28PM +1300, Tony Prisk wrote:
> This patch adds a soc dtsi for the Wondermedia WM8850.
> 
> A board dts file is also included for the W70v2 tablet, with support
> for all the drivers currently in mainline.
> 
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---
> Hi Olof,
> 
> Sorry this is a bit late.

For 3.9? No worries, not late yet.

I've applied this to the same branch as the other wm8x50 patches. I also fixed
up three <space><tab> occurrances in the dtsi that git am complained about.


-Olof
