From: will.deacon@arm.com (Will Deacon)
Date: Tue, 10 Jan 2017 12:41:05 +0000
Subject: [PATCHv6 00/11] CONFIG_DEBUG_VIRTUAL for arm64
In-Reply-To: <e13dc77e-6709-8122-9856-35aee876b836@gmail.com>
References: <1483464113-1587-1-git-send-email-labbott@redhat.com>
 <edc8eaa2-5414-506c-1dad-f2404ef19c81@gmail.com>
 <b3de65da-8a74-2510-268e-34516cc2de77@redhat.com>
 <20170104114449.GA18193@arm.com>
 <e13dc77e-6709-8122-9856-35aee876b836@gmail.com>
Message-ID: <20170110124105.GH21598@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2017 at 02:30:50PM -0800, Florian Fainelli wrote:
> On 01/04/2017 03:44 AM, Will Deacon wrote:
> > On Tue, Jan 03, 2017 at 03:25:53PM -0800, Laura Abbott wrote:
> >> On 01/03/2017 02:56 PM, Florian Fainelli wrote:
> >>> On 01/03/2017 09:21 AM, Laura Abbott wrote:
> >>>> Happy New Year!
> >>>>
> >>>> This is a very minor rebase from v5. It only moves a few headers around.
> >>>> I think this series should be ready to be queued up for 4.11.
> >>>
> >>> FWIW:
> >>>
> >>> Tested-by: Florian Fainelli <f.fainelli@gmail.com>
> >>>
> >>
> >> Thanks!
> >>
> >>> How do we get this series included? I would like to get the ARM 32-bit
> >>> counterpart included as well (will resubmit rebased shortly), but I have
> >>> no clue which tree this should be going through.
> >>>
> >>
> >> I was assuming this would go through the arm64 tree unless Catalin/Will
> >> have an objection to that.
> > 
> > Yup, I was planning to pick it up for 4.11.
> > 
> > Florian -- does your series depend on this? If so, then I'll need to
> > co-ordinate with Russell (probably via a shared branch that we both pull)
> > if you're aiming for 4.11 too.
> 
> Yes, pretty much everything in Laura's patch series is relevant, except
> the arm64 bits.

Ok, then. Laura -- could you please reorder your patches so that the
non-arm64 bits come first? That way, I can put those on a separate branch
and have it pulled by both arm64 and rmk, so that the prequisities are
shared between the architectures.

Thanks,

Will
