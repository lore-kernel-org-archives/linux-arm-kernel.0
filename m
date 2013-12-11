From: dan.j.williams@intel.com (Dan Williams)
Date: Wed, 11 Dec 2013 01:10:27 -0800
Subject: [PATCH] dma: mv_xor: remove mv_desc_get_dest_addr()
In-Reply-To: <20131210111449.GY4360@n2100.arm.linux.org.uk>
References: <1385408365-8072-1-git-send-email-jason@lakedaemon.net>
 <20131128055706.GM8834@intel.com>
 <20131209235035.GA11632@n2100.arm.linux.org.uk>
 <20131210101331.GG29580@intel.com>
 <20131210111449.GY4360@n2100.arm.linux.org.uk>
Message-ID: <CAPcyv4gAazGS_m6KNfF2_kY3CDzYkvpBQ=kcnPH-pBvcJ0HjAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 10, 2013 at 3:14 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Dec 10, 2013 at 03:43:31PM +0530, Vinod Koul wrote:
>> On Mon, Dec 09, 2013 at 11:50:35PM +0000, Russell King - ARM Linux wrote:
>> > On Thu, Nov 28, 2013 at 11:27:06AM +0530, Vinod Koul wrote:
>> > > + Dan
>> > >
>> > > On Mon, Nov 25, 2013 at 07:39:25PM +0000, Jason Cooper wrote:
>> > > > The following commit:
>> > > >
>> > > >   54f8d501e842 dmaengine: remove DMA unmap from drivers
>> > > >
>> > > > removed the last caller to mv_desc_get_dest_addr(), creating the
>> > > > warning:
>> > > >
>> > > >   drivers/dma/mv_xor.c:57:12: warning: 'mv_desc_get_dest_addr' defined
>> > > >   but not used [-Wunused-function]
>> > > >
>> > > > Remove it.
>> > > >
>> > > > Signed-off-by: Jason Cooper <jason@lakedaemon.net>
>> > > Acked-by: Vinod Koul <vinod.koul@intel.com>
>> > >
>> > > This should go thru Dan's tree
>> >
>> > So what's happening with this patch?  I don't see it in -rc yet.
>> Dan has applied this to his next. So this should show us in next rc1
>
> Wrong answer.  This is a compile regression introduced in the last merge
> window, it should be going into an -rc kernel.

Vinod, if your fixes branch is ready I'll take it along with the rest
of the regression fixes to Linus.

--
Dan
