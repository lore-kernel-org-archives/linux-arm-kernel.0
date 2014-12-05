From: akpm@linux-foundation.org (Andrew Morton)
Date: Fri, 5 Dec 2014 14:31:34 -0800
Subject: [RFC] mm:add KPF_ZERO_PAGE flag for /proc/kpageflags
In-Reply-To: <35FD53F367049845BC99AC72306C23D103E688B313F2@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D103E688B313EE@CNBJMBX05.corpusers.net>
 <CALYGNiOuBKz8shHSrFCp0BT5AV6XkNOCHj+LJedQQ-2YdZtM7w@mail.gmail.com>
 <35FD53F367049845BC99AC72306C23D103E688B313F2@CNBJMBX05.corpusers.net>
Message-ID: <20141205143134.37139da2208c654a0d3cd942@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 5 Dec 2014 18:22:33 +0800 "Wang, Yalin" <Yalin.Wang@sonymobile.com> wrote:

> > -----Original Message-----
> > From: Konstantin Khlebnikov [mailto:koct9i at gmail.com]
> > Sent: Friday, December 05, 2014 5:21 PM
> > To: Wang, Yalin
> > Cc: linux-kernel at vger.kernel.org; linux-mm at kvack.org; linux-arm-
> > kernel at lists.infradead.org; akpm at linux-foundation.org; n-
> > horiguchi at ah.jp.nec.com
> > Subject: Re: [RFC] mm:add KPF_ZERO_PAGE flag for /proc/kpageflags
> > 
> > On Fri, Dec 5, 2014 at 11:57 AM, Wang, Yalin <Yalin.Wang@sonymobile.com>
> > wrote:
> > > This patch add KPF_ZERO_PAGE flag for zero_page, so that userspace
> > > process can notice zero_page from /proc/kpageflags, and then do memory
> > > analysis more accurately.
> > 
> > It would be nice to mark also huge_zero_page. See (completely
> > untested) patch in attachment.
> > 
> Got it,
> Thanks for your patch.

Documentation/vm/pagemap.txt will need updating please.
