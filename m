From: olof@lixom.net (Olof Johansson)
Date: Fri, 23 Jan 2015 14:40:59 -0800
Subject: [GIT PULL 1/3] ARM: imx: soc changes for 3.20
In-Reply-To: <20150123091425.GB27337@dragon>
References: <20150123091425.GB27337@dragon>
Message-ID: <20150123224059.GO20896@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 23, 2015 at 05:14:26PM +0800, Shawn Guo wrote:
> The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:
> 
>   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-soc-3.20
> 
> for you to fetch changes up to ade9233f2e0cf4b7bf10fd122c7e9f9310bfd1a5:
> 
>   ARM: clk-imx6q: refine esai_ipg's parent (2015-01-20 15:53:41 +0800)

Merged, thanks.

> Sebastian Andrzej Siewior (1):
>       ARM i.MX6q: unmap memory mapped at imx6q_opp_check_speed_grading()
> 
> Stefan Agner (2):
>       ARM vf610: add compatibilty strings of supported Vybrid SoC's

Tiny nit: ARM: <platform>: <foo>


-Olof
