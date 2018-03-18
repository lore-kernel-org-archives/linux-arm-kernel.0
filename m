From: robh@kernel.org (Rob Herring)
Date: Sun, 18 Mar 2018 07:52:25 -0500
Subject: [PATCH v11 1/2] clk: npcm750: Add binding for Nuvoton NPCM7XX
 clock\n
In-Reply-To: <1521121518-32217-2-git-send-email-tali.perry1@gmail.com>
References: <1521121518-32217-1-git-send-email-tali.perry1@gmail.com>
 <1521121518-32217-2-git-send-email-tali.perry1@gmail.com>
Message-ID: <20180318125225.sp7ppfumxhcbzbfm@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2018 at 03:45:17PM +0200, Tali Perry wrote:
> * Nuvoton NPCM7XX Clock Controller

Trailing '\n' on the subject.
> 
> Nuvoton Poleg BMC NPCM7XX contains an integrated clock controller, which
> generates and supplies clocks to all modules within the BMC.
> 
> 10 ==> 11
> update documentation. "eth" replaced with "ethernet" in use case eaxample.
> 
> 2 ==> 10
> update documentation. add external clocks as inputs to clk driver.
> fix SPDX comment.
> 
> 1 ==> 2
> This patch includes fix request described here:
> https://patchwork.kernel.org/patch/10200033/
> (move fixed clocks to DT)

Changelog goes after the '---' so it doesn't end up in the git commit.

> 
> Signed-off-by: Tali Perry <tali.perry1@gmail.com>
> 
> ---
> 
> 
>  .../bindings/clock/nuvoton,npcm750-clk.txt         | 100 +++++++++++++++++++++
>  include/dt-bindings/clock/nuvoton,npcm7xx-clock.h  |  44 +++++++++
>  2 files changed, 144 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,npcm750-clk.txt
>  create mode 100644 include/dt-bindings/clock/nuvoton,npcm7xx-clock.h

With those fixed,

Reviewed-by: Rob Herring <robh@kernel.org>
