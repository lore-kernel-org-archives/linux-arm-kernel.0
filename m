From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 18 Dec 2012 15:33:01 +0100
Subject: [PATCH] arm: kirkwood: register DT devices earlier
In-Reply-To: <20121218141902.GI3392@lunn.ch>
References: <1355839667-1487-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121218141902.GI3392@lunn.ch>
Message-ID: <20121218153301.6ffced12@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Tue, 18 Dec 2012 15:19:02 +0100, Andrew Lunn wrote:

> I have a different fix for this.
> 
> The gpio is being used to supply power to SATA. So i turn it into a
> fixed-regulator, using DT.
> 
> I will send the patch tonight.

Indeed sounds a much better fix than mine. My patch posting was mainly
to raise the issue, and ensure we get some fix for it, I was quite sure
there was a better way of fixing this.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
