From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Oct 2013 12:43:40 +0100
Subject: Use of drivers/platform and matching include?
In-Reply-To: <20131003170914.GA11992@kroah.com>
References: <BC1C47B3-5412-4829-A1D9-AAB04694D1CC@codeaurora.org>
 <CAOesGMjJ6Uj0uGFJqtnWQyDW+tr6eLVWoHZ+B7uFna+L8N6E8Q@mail.gmail.com>
 <20131003170914.GA11992@kroah.com>
Message-ID: <20131004114340.GM12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 03, 2013 at 10:09:14AM -0700, Greg Kroah-Hartman wrote:
> On Thu, Oct 03, 2013 at 09:46:30AM -0700, Olof Johansson wrote:
> > I don't have a good answer though. If it wasn't for the arm64 fork,
> > locating these under arch/arm somewhere would really be the reasonable
> > answer, like we used to do on powerpc. :(
> 
> Sounds like yet-another-good reason why there shouldn't be an arm64
> "fork" at all :(
> 
> The arm community created this mess, you all can fix it up, it's not too
> late.

I said at the time, way before arm64 was merged that it should not be a
separate arch.  Every bit of feedback I gave on arm64 got shouted down
by Catalin.  ARM64 is Catalin's baby and he wants to protect it at all
costs.  I'm surprised Linus even pulled it in with no argument.
