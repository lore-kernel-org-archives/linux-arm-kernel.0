From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 May 2012 20:07:51 +0100
Subject: How to check if a patch is applied, ejected or ignored?
In-Reply-To: <4FA81C16.8070204@broadcom.com>
References: <4FA81C16.8070204@broadcom.com>
Message-ID: <20120507190751.GA12133@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 07, 2012 at 12:01:42PM -0700, Jiandong Zheng wrote:
> Hello,
>
> Sorry if it is not the first time about such question. But I still get  
> confused about if my patches are applied or just ignored.
>
> For example, I didn't see much response about the following patches and  
> I don't know how to check if they are already in a tree to be merged to  
> Linus':
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-May/097346.html
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-May/097347.html
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-May/097349.html
> (BTW, a couple of them were sent multiple times before)
>
> Previously I was told to use patch system once and for a couple of other  
> times the patches were just got applied, and ignored patches happened  
> more. I hope a clear procedure can be clarified so that we can work more  
> efficiently.

I only very rarely apply patches which aren't in the patch system.

Now that we have arm-soc, I leave most patches to SoCs to Arnd & Olof to
deal with, so I guess you should be sending these patches there now.
