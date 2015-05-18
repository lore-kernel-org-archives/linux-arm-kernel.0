From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 18 May 2015 22:20:33 +0200
Subject: ARMADAXP MV78260 CPU-1:failed to come online
In-Reply-To: <CAG1O52XwiW9a0+XS==vNAiKoYiVg7TR5XfYrQxHO7R089RWcfg@mail.gmail.com>
References: <CAG1O52XwiW9a0+XS==vNAiKoYiVg7TR5XfYrQxHO7R089RWcfg@mail.gmail.com>
Message-ID: <20150518202033.GH21807@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas, Gregory

On Tue, May 19, 2015 at 01:17:26AM +0530, raghu MG wrote:
> Hi,
> This mail is regarding Linux smp boot on ARMADA-XP MV2860
> .
> 
> CPU-1 doesnt boot/go through the boot sequence & it fails to come
> online & dumps this message
> 
> CPU1:failed to come online .
> 
> The CPU-1 boot register is programmed with physical address of
> -->armada_xp_secondary_startup function & then cpu-0 deasserts the CPU-1.
> 
> I am using armada-xp-gp.dts ,I included armada-xp-mv78260.dts in it.

Does this ring any bells? I have vague recollections of a u-boot
issue?

     Andrew
