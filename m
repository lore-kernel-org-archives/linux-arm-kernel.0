From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Wed, 06 Oct 2010 10:19:21 +0200
Subject: MX3: compile breakage with next
In-Reply-To: <Pine.LNX.4.64.1010060857280.9687@axis700.grange>
References: <Pine.LNX.4.64.1010060857280.9687@axis700.grange>
Message-ID: <4CAC3109.1020000@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guennadi,

Le 06/10/2010 09:13, Guennadi Liakhovetski a ?crit :
 > Trying to build an i.MX31 kernel with yesterday's next, getting this:
 >
 >    CC      arch/arm/kernel/setup.o
 > /tmp/cc20jofu.s: Assembler messages:
 > /tmp/cc20jofu.s:131: Error: selected processor does not support ARM 
mode `isb'
 > make[1]: *** [arch/arm/kernel/setup.o] Error 1
 > make: *** [arch/arm/kernel] Error 2
 >
 > Is it known? Any fix yet?
 >
please see here as this seems to be the same problem :
http://www.spinics.net/lists/arm-kernel/msg100625.html

Eric
