From: horms@verge.net.au (Simon Horman)
Date: Sun, 24 Nov 2013 16:16:15 +0900
Subject: [GIT PULL] Renesas ARM based SoC clock updates for v3.13
In-Reply-To: <1381301313-5938-1-git-send-email-horms+renesas@verge.net.au>
References: <1381301313-5938-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20131124071615.GA15677@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 09, 2013 at 03:48:32PM +0900, Simon Horman wrote:
> Hi Mike,
> 
> please consider these Renesas ARM based SoC clock updates for v3.13.

Hi Mike,

for some reason I thought you had taken this change but I now
realise that is not the case. I apologise for not being more attentive.

I am wondering if you could consider taking it as I have some SoC-side
changes that depend on it which I would like to queue up for v3.14.
Actually, I have them queued up and was preparing some branches based on
v3.13-rc1 for the ARM-SoC maintainers when I noticed this patch
had not been accepted.

I think that any of the following would work well for me:
I'm sure there are also other options.

1. You could take this into a branch which won't subsequently
   be rebased and I can use that as a base for a branch
   for the SoC-side changes which I intend to have merged into
   the ARM-SoC tree.

2. You could take this for v3.13. But it is probably far to late for that.

3. I could take this change with the SoC-side changes which I
   intend to have merged into the ARM-SoC tree.

Another option is for me to drop the SoC-side changes for now.
But that is not my preferred option.

> 
> 
> The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:
> 
>   Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-clock-for-v3.13
> 
> for you to fetch changes up to f00578d0f860ba63bf28e0261ef489cc9e01ab47:
> 
>   clk: emev2: Add support for emev2 SMU clocks with DT (2013-10-09 15:39:08 +0900)
> 
> ----------------------------------------------------------------
> Renesas ARM based SoC clock updates for v3.13
> 
> * Add support for emev2 SMU clocks with DT
> 
> ----------------------------------------------------------------
> Takashi Yoshii (1):
>       clk: emev2: Add support for emev2 SMU clocks with DT
> 
>  .../devicetree/bindings/clock/emev2-clock.txt      |  98 +++++++++++++++++++
>  drivers/clk/Makefile                               |   1 +
>  drivers/clk/shmobile/Makefile                      |   3 +
>  drivers/clk/shmobile/clk-emev2.c                   | 104 +++++++++++++++++++++
>  4 files changed, 206 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/emev2-clock.txt
>  create mode 100644 drivers/clk/shmobile/Makefile
>  create mode 100644 drivers/clk/shmobile/clk-emev2.c
> 
