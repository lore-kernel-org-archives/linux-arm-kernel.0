From: jchandra@broadcom.com (Jayachandran C)
Date: Wed, 6 Apr 2016 00:20:32 +0530
Subject: [PATCH V5 01/15] ACPI: MCFG: Move mmcfg_list management to
 drivers/acpi
In-Reply-To: <20160405164122.GA9419@localhost>
References: <1455630825-27253-1-git-send-email-tn@semihalf.com>
 <1455630825-27253-2-git-send-email-tn@semihalf.com>
 <20160303225152.GA10472@localhost>
 <CAKc_7PUyf8ND8Nd32yDBtBnFbkd1mJ-VsCih6YsEA5ZuBUz5zA@mail.gmail.com>
 <20160305041443.GA15110@localhost> <56DFE91E.10105@semihalf.com>
 <5703C7AB.2000306@semihalf.com> <20160405164122.GA9419@localhost>
Message-ID: <CAKc_7PWFGJSYk0nmLX7cG_1HDHdKSK7NCwWN0_G_e+WwqEs5aQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On Tue, Apr 5, 2016 at 10:11 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Hi Tomasz,
>
> On Tue, Apr 05, 2016 at 04:11:55PM +0200, Tomasz Nowicki wrote:
> > On 09.03.2016 10:13, Tomasz Nowicki wrote:
> > >Hi Bjorn,
> > >
> > >Thanks for your pointers! See my comments inline. Aslo, can you please
> > >have a look at my previous patch set v4 and check how many of your
> > >comments are already addressed there. We may want to back to it then.
> > >
> > >https://lkml.org/lkml/2016/2/4/646
> > >Especially patches [0-6] which handle MMCONFIG refactoring.
> > >
> > >
> > >On 05.03.2016 05:14, Bjorn Helgaas wrote:
> [...]
> > >
> > >As you pointed out raw_pci_{read|write} make things complicated, so IMO
> > >we should either say they are absolutely necessary (and then think how
> > >to simplify it) or just use simple bus-specific accessor (patch 02/15)
> > >e.g. for ARM64.
> > >
> > >Any comments appreciated.
>
> > Kindly reminder. I would like to move on with this patch set. Can
> > you please comments on it so that we could decide which way to go.
>
> Can you repost your current proposal with a version number higher than
> any previous ones?  It's OK if the content is the same as v4; I just
> think it's confusing if we resurrect v4 and have to follow discussion
> from v3 to v4 to v5 and back to v4.  The archives would be a bit of a
> muddle.

I had posted a patchset based on your suggestions in this thread
https://lkml.org/lkml/2016/3/17/621

Would appreciate any comments on that. Like I said in the earlier
mail, if this is a reasonable approach, I can combine this with
Tomasz patchset to provide the full patchset for ACPI support.

Thanks,
JC.
