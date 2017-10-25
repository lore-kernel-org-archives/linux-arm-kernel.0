From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 25 Oct 2017 23:24:01 +0200
Subject: [PATCH] rtc: armada38x: add support for trimming the RTC
In-Reply-To: <E1dxsSB-0006RM-08@rmk-PC.armlinux.org.uk>
References: <E1dxsSB-0006RM-08@rmk-PC.armlinux.org.uk>
Message-ID: <20171025212401.bjcydrc6mg3jpoe5@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/09/2017 at 11:23:31 +0100, Russell King wrote:
> Add support for trimming the RTC using the offset mechanism.  This RTC
> supports two modes: low update mode and high update mode.  Low update
> mode has finer precision than high update mode, so we use the low mode
> where possible.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/rtc/rtc-armada38x.c | 101 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 101 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
