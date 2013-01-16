From: olof@lixom.net (Olof Johansson)
Date: Wed, 16 Jan 2013 14:27:45 -0800
Subject: [GIT PULL] sunxi fixes for 3.8
In-Reply-To: <50F6F028.6060009@free-electrons.com>
References: <50F6F028.6060009@free-electrons.com>
Message-ID: <20130116222745.GA9035@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 16, 2013 at 07:23:36PM +0100, Maxime Ripard wrote:
> Hi Olof, Arnd,
> 
> Please consider pulling the following patch for 3.8.
> 
> The sunxi UARTs are actually not a regular 8250 but rather uses a
> Synopsys DPB compatible UART.
> 
> This patch fixes that.
> 
> Thanks,
> Maxime
> 
> The following changes since commit 43880f709dc59840849e31b01735ac587195ef8a:
> 
>   sunxi: Change the machine compatible string. (2012-12-23 18:20:15 +0100)
> 
> are available in the git repository at:
> 
>   git://github.com/mripard/linux.git tags/sunxi-fixes-for-3.8-rc4
> 
> for you to fetch changes up to 1bea07f16da0d77689cda7abe73939dd1dfdea22:
> 
>   ARM: sunxi: Use the Synosys APB UART instead of ns8250 (2013-01-16 19:13:18 +0100)

Pulled, thanks.

-Olof
