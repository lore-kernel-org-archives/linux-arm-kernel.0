From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 19 Jan 2015 01:17:05 +0100
Subject: [PATCH] USB: host: ehci_atmel: Add suspend/resume support
In-Reply-To: <20150117160304.GA21820@gradator.net>
References: <1421437274-31615-1-git-send-email-sylvain.rochet@finsecur.com>
 <20150117013442.GV3843@piout.net>
 <20150117103609.276efecf@bbrezillon>
 <20150117104259.GA24176@gradator.net>
 <20150117135857.71dae08f@bbrezillon>
 <20150117160304.GA21820@gradator.net>
Message-ID: <20150119001705.GA5014@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/01/2015 at 17:03:04 +0100, Sylvain Rochet wrote :
> Should I have added the "Acked-by: Alexandre Belloni 
> <alexandre.belloni@free-electrons.com>" on 1/2 ?
> 

Yes, you could. Just a small remark, you send both patches as separate
in v1, you should have kept them separate so it is easier to understand
what v2 is relating to. Also, I don't think you need to use
--in-reply-to when sending v2.

Finally, please including a changelog after the '---' marker in each patch
or in the cover letter.

Those are simply small things and your work is great.

> As a side note, unfortunately AT91 slow clock mode only work on "recent" 
> boards with Wenyou changes on linux4sam/linux-at91/linux-3.10-at91 
> branch and is why I am still stuck to this branch (and the HLCDC FB 
> driver, but this is going to be merged soon from what I saw, YAY !).
> 

Work is in progress to get that in 3.20 or 3.21.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
