From: olof@lixom.net (Olof Johansson)
Date: Tue, 6 Nov 2012 06:00:51 -0800
Subject: [GIT PULL][for 3.8] pull request from upload/board in arch-pxa
 git tree
In-Reply-To: <CAN1soZzhb361Gs9JVmhkjqqcr6FkGg9MVO_n9Tv29F==HdhwQQ@mail.gmail.com>
References: <CAN1soZzhb361Gs9JVmhkjqqcr6FkGg9MVO_n9Tv29F==HdhwQQ@mail.gmail.com>
Message-ID: <20121106140051.GB27284@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 28, 2012 at 07:59:54AM +0800, Haojian Zhuang wrote:
> Hi Arnd & Olof,
> 
> Please help to pull upload/board branch from arch-pxa git tree.
> 
> Best Regards
> Haojian
> 
> The following changes since commit 6f0c0580b70c89094b3422ba81118c7b959c7556:
> 
>   Linux 3.7-rc2 (2012-10-20 12:11:32 -0700)
> 
> are available in the git repository at:
> 
>   git://github.com/hzhuang1/linux.git upload/board
> 
> for you to fetch changes up to f534958f092bab25eadc25dbfa01657918239b77:
> 
>   ARM: pxa: use module_platform_driver macro (2012-10-26 17:25:15 +0800)
> 
> ----------------------------------------------------------------
> Paul Parsons (1):
>       ARM: pxa2xx: Remove EXPERIMENTAL dependency from spi-pxa2xx driver

This is a SPI driver change, and should either go through or be acked by that
maintainer. In this particular case, there's been several series of the
EXPERIMENTAL removals, and I think Kees Cook has one that removes it for all
options in one go. So please ack that patch instead.


> Srinivas Kandagatla (1):
>       ARM: pxa: use module_platform_driver macro

This looks like a cleanup, so I have cherry-picked it into our cleanup branch.

Based on the above, no need to resend this, but please follow up on the
EXPERIMENTAL cleanup by Kees.


-Olof
