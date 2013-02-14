From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 14 Feb 2013 15:09:57 +0530
Subject: [PATCH V4 0/5] Add generic DMA DT binding support
In-Reply-To: <CAAgF-BfAE4Qt5KOBsn1iD7HW7_1e=TSEbuxNuTk0w8X+t3i-5Q@mail.gmail.com>
References: <1360571905-15285-1-git-send-email-padma.v@samsung.com>
 <20130212144950.GJ3789@intel.com>
 <CAAgF-Be1w-8yjuyXT+d8sUO8dee1x7oYFJLXHCmcJSf17eXWyw@mail.gmail.com>
 <20130214044704.GE7777@intel.com>
 <CAAgF-BfAE4Qt5KOBsn1iD7HW7_1e=TSEbuxNuTk0w8X+t3i-5Q@mail.gmail.com>
Message-ID: <20130214093957.GB27887@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 14, 2013 at 11:12:51AM +0530, Padma Venkat wrote:
> Hi Vinod,
> 
> On Thu, Feb 14, 2013 at 10:17 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> > On Wed, Feb 13, 2013 at 09:52:30AM +0530, Padma Venkat wrote:
> >> Hi Vinod,
> >>
> >> On Tue, Feb 12, 2013 at 8:19 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> >> > On Mon, Feb 11, 2013 at 02:08:20PM +0530, Padmavathi Venna wrote:
> >> >
> >> > This looks fine, I have only question. The code seems to assume that pl330 dma
> >> > controller always uses DT. But I dont see that as dependency for pl330.
> > Have you checked this?
> 
> Sorry I didn't see this comment previously. I verified on SMDK6410
> board which doesn't have DT support.
> I didn't see any build error and it detected the sound card.
Okay, sound good...

I will try the series now.

--
~Vinod
