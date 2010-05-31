From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 31 May 2010 08:57:31 -0400 (EDT)
Subject: pxa-devel back-merge / cherry pick request
In-Reply-To: <20100531114815.GF2695@buzzloop.caiaq.de>
References: <20100531114815.GF2695@buzzloop.caiaq.de>
Message-ID: <alpine.LFD.2.00.1005310855250.24526@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 31 May 2010, Daniel Mack wrote:

> Hi Eric,
> 
> Is there any plans to merge Linus' tree into your pxa-devel any time
> soon? I'm asking because I have one patch pending which depends on
> 
>   a3bcbbee ("pda_power: Add function callbacks for suspend and resume")
> 
> upstream. Alternatively, could you cherry-pick this one commit?

Even better is for you to fork a branch starting at that particular 
commit, apply your patch on top, then ask Eric to pull it.


Nicolas
