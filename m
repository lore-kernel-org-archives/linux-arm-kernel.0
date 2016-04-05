From: tn@semihalf.com (Tomasz Nowicki)
Date: Tue, 5 Apr 2016 20:07:59 +0200
Subject: [PATCH V5 01/15] ACPI: MCFG: Move mmcfg_list management to
 drivers/acpi
In-Reply-To: <20160405164122.GA9419@localhost>
References: <1455630825-27253-1-git-send-email-tn@semihalf.com>
 <1455630825-27253-2-git-send-email-tn@semihalf.com>
 <20160303225152.GA10472@localhost>
 <CAKc_7PUyf8ND8Nd32yDBtBnFbkd1mJ-VsCih6YsEA5ZuBUz5zA@mail.gmail.com>
 <20160305041443.GA15110@localhost> <56DFE91E.10105@semihalf.com>
 <5703C7AB.2000306@semihalf.com> <20160405164122.GA9419@localhost>
Message-ID: <5703FEFF.202@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On 05.04.2016 18:41, Bjorn Helgaas wrote:
> Hi Tomasz,
>

[...]

>>>>
>>>
>>> As you pointed out raw_pci_{read|write} make things complicated, so IMO
>>> we should either say they are absolutely necessary (and then think how
>>> to simplify it) or just use simple bus-specific accessor (patch 02/15)
>>> e.g. for ARM64.
>>>
>>> Any comments appreciated.
>>
>> Kindly reminder. I would like to move on with this patch set. Can
>> you please comments on it so that we could decide which way to go.
>
> Can you repost your current proposal with a version number higher than
> any previous ones?  It's OK if the content is the same as v4; I just
> think it's confusing if we resurrect v4 and have to follow discussion
> from v3 to v4 to v5 and back to v4.  The archives would be a bit of a
> muddle.
>

Sure I will repost ASAP.

Thanks!
Tomasz
