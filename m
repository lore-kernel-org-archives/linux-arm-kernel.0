From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 31 May 2010 13:47:50 +0100
Subject: pxa-devel back-merge / cherry pick request
In-Reply-To: <20100531114815.GF2695@buzzloop.caiaq.de>
References: <20100531114815.GF2695@buzzloop.caiaq.de>
Message-ID: <20100531124750.GA21679@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 31, 2010 at 01:48:16PM +0200, Daniel Mack wrote:
> Hi Eric,
> 
> Is there any plans to merge Linus' tree into your pxa-devel any time
> soon? I'm asking because I have one patch pending which depends on
> 
>   a3bcbbee ("pda_power: Add function callbacks for suspend and resume")
> 
> upstream. Alternatively, could you cherry-pick this one commit?

Please don't cherry-pick commits back into branches which will eventually
find their way back into mainline.
