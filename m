From: akpm@linux-foundation.org (Andrew Morton)
Date: Mon, 7 Mar 2016 22:32:01 -0800
Subject: next-20160307 build: 2 failures 19 warnings (next-20160307)
In-Reply-To: <002b01d17903$59b2ae00$0d180a00$@lge.com>
References: <E1actUq-0008MZ-EF@optimist> <20160308022056.GV18327@sirena.org.uk>
 <002b01d17903$59b2ae00$0d180a00$@lge.com>
Message-ID: <20160307223201.06f055f4.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 8 Mar 2016 15:25:46 +0900 "Joonsoo Kim" <iamjoonsoo.kim@lge.com> wrote:

> 
> 
> > -----Original Message-----
> > From: Mark Brown [mailto:broonie at kernel.org]
> > Sent: Tuesday, March 08, 2016 11:21 AM
> > To: Andrew Morton; Joonsoo Kim; Michal Nazarewicz; Steven Rostedt; Mel
> > Gorman; Minchan Kim; Sergey Senozhatsky; Kirill A. Shutemov; Catalin
> > Marinas; Will Deacon
> > Cc: kernel-build-reports at lists.linaro.org; linaro-kernel at lists.linaro.org;
> > linux-next at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> > Subject: Re: next-20160307 build: 2 failures 19 warnings (next-20160307)
> > 
> > On Mon, Mar 07, 2016 at 11:38:44AM +0000, Build bot for Mark Brown wrote:
> > 
> > For the past week or so an arm64 allmodconfig has failed to build.  I've
> > not been able to perform a bisect to identify where as I've been
> > travelling but the errors are below, I suspect they are triggered by
> > recent changes in the akpm tree adding tracepoints to the page reference
> > code.
> 
> Hello,
> 
> It's already reported problem and solved by following patch.
> 
> http://ozlabs.org/~akpm/mmots/broken-out/mm-page_ref-add-tracepoint-to-track
> -down-page-reference-manipulation-fix-3.patch
> 
> Once Andrew releases new mmotm and it is applied to linux-next,
> no error will happen.

Yes, sorry, I have been remiss in cc'ing Stephen on things like this :(
