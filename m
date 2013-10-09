From: robdclark@gmail.com (Rob Clark)
Date: Wed, 9 Oct 2013 10:48:34 -0400
Subject: [PATCH 0/5] Armada DRM stuff
In-Reply-To: <20131009143120.GI25034@n2100.arm.linux.org.uk>
References: <20131006220728.GG12758@n2100.arm.linux.org.uk>
 <52532C0B.3090503@gmail.com>
 <20131009143120.GI25034@n2100.arm.linux.org.uk>
Message-ID: <CAF6AEGtPtLHZiJbTFJ5BDpWzfD-o3cH=FHnQAg9TPs0p_ZKQEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 9, 2013 at 10:31 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Oct 07, 2013 at 11:47:55PM +0200, Sebastian Hesselbarth wrote:
>> On 10/07/2013 12:07 AM, Russell King - ARM Linux wrote:
>>> The Armada DRM drivers again, along with the TDA998x HDMI output support,
>>> and an illustration to show how to add Armada 610 support (and others.)
>>>
>>> Rob has looked at this a couple of times since its last posting, and
>>> has provided additional useful feedback which has been incorporated.
>>> I believe all the major issues have been addressed now.
>>
>> Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>>
>> on Marvell Armada 510, SolidRun CuBox with quick-hack DT support added.
>>
>> Let's please get this driver mainlined and start working on proper DT
>> support for it. Thanks for driver and the patience to work out all
>> issues!
>
> Sebastian,
>
> I've added your tested-by now, and also updated the TDA998x patch to use
> the HDMI definitions that Jean-Francois pointed out (which is a really
> small delta, so isn't worth resending the patch set just for that).
> Thanks.
>
> All the points brought up in previous reviews concerning the physical
> address exposure, and the location of the DRM helpers have all been
> addressed, so it is now ready to be merged into mainline.  So now the
> question is how to proceed with it.
>
> However, I see no response from any DRM developers, even though they are
> around - they've been responding on a different thread about driver
> model/sysfs abuse by DRM.
>
> I'm going to pull it into my nightly build tree so it can have some
> testing with non-dove builds, and if there's still no response from
> DRM people next week, I'll put it in to linux-next via my tree so at
> least it can get some exposure and integration validation there.

fyi, I think this is in pretty good shape.. I've reviewed earlier
versions, and had an initial look at this version which addresses my
concerns, although I still intend to give a closer review of the final
version (still on my TODO list, but we have a bit of time before 3.13
merge window.. I should at least get to it by the weekend)

BR,
-R
