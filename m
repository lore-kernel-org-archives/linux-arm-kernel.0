From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 11 Jun 2015 17:14:17 +0200
Subject: [PATCH] ARM: mvebu: pass the coherency availability information
 at init time
In-Reply-To: <20150611145129.GA3777@kroah.com>
References: <1433992764-12753-1-git-send-email-gerg@uclinux.org>
 <20150611034521.GA12809@kroah.com> <557908C2.4090302@uclinux.org>
 <20150611092549.2276beb8@free-electrons.com>
 <20150611145129.GA3777@kroah.com>
Message-ID: <20150611171417.3cc53d62@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg,

On Thu, 11 Jun 2015 07:51:29 -0700, Greg KH wrote:

> > As the original author of 5686a1e5aa4 ("bus: mvebu: pass the coherency
> > availability information at init time"), I can confirm that it will
> > clearly not apply as is on 3.10. What Greg Ungerer is proposing here is
> > a backport of 5686a1e5aa4 to 3.10.
> 
> What about 3.14-stable?

5686a1e5aa4 was merged in 3.16, and it should be backported all the way
up to when Armada 370 support was merged with I/O coherency support,
i.e in 3.8.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
