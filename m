From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 3 Jan 2013 21:48:05 -0500 (EST)
Subject: Early kernel hang with big DTB appended
In-Reply-To: <7811936.npteFbuYu2@amdc1227>
References: <7811936.npteFbuYu2@amdc1227>
Message-ID: <alpine.LFD.2.02.1301032144490.1263@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 3 Jan 2013, Tomasz Figa wrote:

> Hi,
> 
> I'm observing strange behavior when booting 3.8-rc1 and -rc2 with appended 
> DTB. The kernel hangs very early when the DTB is bigger than some 
> threshold somewhere around 24 KiB.

What is the address where you load your zImage?

What if you load it, say, at an offset of 16MB from the start of RAM?  
Not that this is a fix, but at least that would help isolate the issue.


Nicolas
