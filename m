From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 13 Jun 2012 10:42:06 -0400 (EDT)
Subject: [RFC 3/4] ARM: topology: Update cpu_power according to DT
 information
In-Reply-To: <1339592984.8980.34.camel@twins>
References: <1339502524-10265-1-git-send-email-vincent.guittot@linaro.org>
 <1339502524-10265-4-git-send-email-vincent.guittot@linaro.org>
 <1339592984.8980.34.camel@twins>
Message-ID: <alpine.LFD.2.02.1206131038060.23555@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 13 Jun 2012, Peter Zijlstra wrote:

> On Tue, 2012-06-12 at 14:02 +0200, Vincent Guittot wrote:
> > +#ifdef CONFIG_OF
> 
> That must really be the worst CONFIG_ name ever..

Indeed!  We must corner Grant to do a s/CONFIG_OF/CONFIG_DEVICE_TREE/
on the whole tree and send the patch to Linus.  He just managed to 
chicken away from doing it so far.


Nicolas
