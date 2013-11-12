From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Tue, 12 Nov 2013 14:40:33 +0000
Subject: Physical memory start contraints in the Linux kernel (Was: Re:
 Xen osstest on Calxeda midway progress (Was: Re: [Xen-devel] [xen-unstable
 test] 21486: tolerable FAIL - PUSHED))
In-Reply-To: <52823C9E.2010007@linaro.org>
References: <osstest-21486-mainreport@xen.org>
 <1384250005.1883.35.camel@kazak.uk.xensource.com>
 <alpine.DEB.2.02.1311121212240.26077@kaball.uk.xensource.com>
 <201311121437.55826.arnd@arndb.de> <52823C9E.2010007@linaro.org>
Message-ID: <1384267233.10204.20.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-11-12 at 14:35 +0000, Julien Grall wrote:
> On 11/12/2013 01:37 PM, Arnd Bergmann wrote:
> > BTW, does Dom0 require an LPAE-enabled kernel or can it be a regular
> > non-LPAE ARMv6/v7 multiplatform build?
> 
> It can be both.

NB: v7 only, we don't do v6 at all. But yes either LPAE or regular is
fine with us.

Ian.
