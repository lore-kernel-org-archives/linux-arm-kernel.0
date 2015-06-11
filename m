From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 11 Jun 2015 09:25:49 +0200
Subject: [PATCH] ARM: mvebu: pass the coherency availability information
 at init time
In-Reply-To: <557908C2.4090302@uclinux.org>
References: <1433992764-12753-1-git-send-email-gerg@uclinux.org>
 <20150611034521.GA12809@kroah.com> <557908C2.4090302@uclinux.org>
Message-ID: <20150611092549.2276beb8@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg, Greg,

On Thu, 11 Jun 2015 14:04:18 +1000, Greg Ungerer wrote:

> > Why?  What's wrong with taking the exact specific upstream patches
> > instead?
> 
> The exact patch mentioned below ("5686a1e5aa4") will not apply.
> Too much of the code around it has changed. This does the same
> thing in the same away taking into account the changes around it.

As the original author of 5686a1e5aa4 ("bus: mvebu: pass the coherency
availability information at init time"), I can confirm that it will
clearly not apply as is on 3.10. What Greg Ungerer is proposing here is
a backport of 5686a1e5aa4 to 3.10.

The mistake is that 5686a1e5aa4 should have been marked for stable
really.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
