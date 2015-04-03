From: olof@lixom.net (Olof Johansson)
Date: Fri, 3 Apr 2015 13:58:01 -0700
Subject: [GIT PULL 2/4] ARM: imx: soc changes for 4.1
In-Reply-To: <CAAQ0ZWT+-s9V6GtYAQKoF0Qk8XZctSnSemkvqR6twD0Nxo+KTw@mail.gmail.com>
References: <CAAQ0ZWT+-s9V6GtYAQKoF0Qk8XZctSnSemkvqR6twD0Nxo+KTw@mail.gmail.com>
Message-ID: <20150403205801.GK23023@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 30, 2015 at 10:02:26PM +0800, Shawn Guo wrote:
> The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:
> 
>   Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
> tags/imx-soc-4.1
> 
> for you to fetch changes up to ae4aee959f7959427e99edb3927c9512986cbdc5:
> 
>   ARM: imx: depend MXC debug board on 3DS machines (2015-03-13 21:55:29 +0800)
> 
> ----------------------------------------------------------------
> The i.MX SoC changes for 4.1:
>  - An error handling improvement on imx-weim bus driver
>  - A number of imx6q clock tree update around MIPI support
>  - Add support for i.MX6 GPU/VPU power domain
>  - Enable SMP_ON_UP build for Vybrid
>  - Let MXC_DEBUG_BOARD depend on 3-stack (3DS) boards

Merged, thanks.


-Olof
