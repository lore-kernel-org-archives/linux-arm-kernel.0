From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 12 Sep 2012 20:34:46 +0530
Subject: [PATCH] CPUFreq: OMAP: remove unnecessary plat/ includes
In-Reply-To: <87bohbxs16.fsf@deeprootsystems.com>
References: <alpine.DEB.2.00.1209120030420.9444@utopia.booyaka.com>
 <CAMQu2gz4mcxqq=EFJzseXcgS_XxzDWGTP1sC5-FbkbxszUiwcw@mail.gmail.com>
 <87bohbxs16.fsf@deeprootsystems.com>
Message-ID: <CAMQu2gwpD6qOEV7sPg9zfMf1Zedq29OJeZ4MwEqUduZh8fJzhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2012 at 7:27 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> "Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:
>
>> On Wed, Sep 12, 2012 at 6:02 AM, Paul Walmsley <paul@pwsan.com> wrote:
>>>
>>> Remove some unnecessary plat/ includes that are interfering with multi-subarch
>>> ARM kernels.
>>>
>>> Signed-off-by: Paul Walmsley <paul@pwsan.com>
>>> Cc: Kevin Hilman <khilman@ti.com>
>>> Cc: Rafael J. Wysocki <rjw@sisk.pl>
>>> Acked-by: Kevin Hilman <khilman@ti.com>
>>> ---
>>>
>>> Still awaiting some final testing here.  Rafael, was wondering if you
>>> would be willing to ack this so we can merge it via the OMAP tree?
>>> Otherwise the patch can be split into an OMAP part and a CPUFreq part that
>>> can go in across two merge windows.
>>>
>> Hmm.
>> I did similar change[1] a while back. Kevin didn't like idea though
>> that point of time.
>
> I was wrong.
>
> At the time, we were thinking about how to get rid of clkdev nodes
> instead of add more.  Now, we need to clean up these drivers and this is
> the only way to do it, so I retract my objection.
>
Thanks for clarifying.

For patch itself,
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
