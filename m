From: olof@lixom.net (Olof Johansson)
Date: Thu, 17 Nov 2016 23:19:32 -0800
Subject: [GIT PULL] pxa-dt for v4.10
In-Reply-To: <8760nxwqs0.fsf@belgarion.home>
References: <8760nxwqs0.fsf@belgarion.home>
Message-ID: <20161118071932.GB1785@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 08, 2016 at 11:27:59PM +0100, Robert Jarzmik wrote:
> Hi Arnd, Kevin, and Olof,
> 
> This is the pxa pull request for 4.10 device-tree, can you please consider
> pulling ?
> 
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/rjarzmik/linux.git tags/pxa-dt-4.10
> 
> for you to fetch changes up to f409d2f134d499354dca0613693f27d8efd75c74:
> 
>   ARM: dts: pxa: add pxa27x cpu operating points (2016-11-02 22:52:45 +0100)
> 
> ----------------------------------------------------------------
> This device-tree pxa update brings :
>  - pxa25x support
>  - cpu operating points in preparation for cpufreq-dt
>  - small fixes
> 
> ----------------------------------------------------------------
> Robert Jarzmik (4):
>       ARM: dts: add pxa25x .dtsi file
>       ARM: dts: pxa: fix gpio0 and gpio1 interrupts
>       ARM: dts: pxa: add pxa25x cpu operating points
>       ARM: dts: pxa: add pxa27x cpu operating points
> 
> Vijay Kumar (1):
>       Fix no. of gpio cells in the pxa gpio binding doucmentation

This isn't the right patch subject. Please use standard prefix format
here (ARM: dts: pxa: ...).


Please respin this branch and post a fresh pull request. Thanks!


-Olof
