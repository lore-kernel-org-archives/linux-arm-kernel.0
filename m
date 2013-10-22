From: davidb@codeaurora.org (David Brown)
Date: Mon, 21 Oct 2013 23:47:23 -0700
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <alpine.LFD.2.03.1310201911190.1951@syhkavp.arg>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131020220839.GT2443@sirena.org.uk>
 <5264576F.6050307@wwwdotorg.org>
 <alpine.LFD.2.03.1310201911190.1951@syhkavp.arg>
Message-ID: <20131022064723.GA15861@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 20, 2013 at 09:00:08PM -0400, Nicolas Pitre wrote:

>The hardware support in the kernel, on the other hand, can be improved
>incrementally with time.  It doesn't matter if it is not optimal at
>first. It can be revisited, optimized, reviewed, and sometimes even
>redesigned.  And only when it reaches maturity would be the time to use
>the experience from the kernel development and make some firmware out of
>it.  But what would be the point then?

One other point that is kind of overlooked, but I think is important,
is that firmware will tend to be closed source.  The advantages we get
to having drivers shared in the kernel would be gone, and we would end
up with multiple implementations of essentially the same driver,
especially with reference hardware blocks that get used in different
platforms.

David

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
