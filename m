From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 12 Oct 2016 10:48:11 +0100
Subject: [RFC 0/1] misc: Add Allwinner Q8 tablet hardware manager
In-Reply-To: <CAL_JsqJVkPPiDh66nhfh0D7BvkZ7KKN0X7uhfPGgiYbc2Ca1rg@mail.gmail.com>
References: <20160901190820.21987-1-hdegoede@redhat.com>
 <CAL_JsqJVkPPiDh66nhfh0D7BvkZ7KKN0X7uhfPGgiYbc2Ca1rg@mail.gmail.com>
Message-ID: <20161012094811.GA19509@remoulade>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Sep 09, 2016 at 04:32:06PM -0500, Rob Herring wrote:
> On Thu, Sep 1, 2016 at 2:08 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> > Hi All,
> >
> > Here is a first RFC for the q8 tablet hw-manager I've been talking
> > about for a while now.
> >
> > The touchscreen part is finished, I'll start working on the
> > accelerometer bits next.
> 
> This at least partially overlaps with the "overlay manager" just
> posted. A dev board having different devices attached and a production
> device have 2nd source components are not really different problems.
> We need a common solution and can't have each platform making up their
> own scheme.

To follow up discussions at ELC-E, I agree that we need a common solution (if
this has to happen in the kernel rather than in an earlier stage of the boot
process).

Otherwise, we're creating pseudo-board-files, and a whole new set of problems
for ourselves.

Thanks
Mark.
