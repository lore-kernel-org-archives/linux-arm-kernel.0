From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 12 Sep 2012 06:57:41 -0700
Subject: [PATCH] CPUFreq: OMAP: remove unnecessary plat/ includes
In-Reply-To: <CAMQu2gz4mcxqq=EFJzseXcgS_XxzDWGTP1sC5-FbkbxszUiwcw@mail.gmail.com>
 (Santosh Shilimkar's message of "Wed, 12 Sep 2012 12:58:28 +0530")
References: <alpine.DEB.2.00.1209120030420.9444@utopia.booyaka.com>
 <CAMQu2gz4mcxqq=EFJzseXcgS_XxzDWGTP1sC5-FbkbxszUiwcw@mail.gmail.com>
Message-ID: <87bohbxs16.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:

> On Wed, Sep 12, 2012 at 6:02 AM, Paul Walmsley <paul@pwsan.com> wrote:
>>
>> Remove some unnecessary plat/ includes that are interfering with multi-subarch
>> ARM kernels.
>>
>> Signed-off-by: Paul Walmsley <paul@pwsan.com>
>> Cc: Kevin Hilman <khilman@ti.com>
>> Cc: Rafael J. Wysocki <rjw@sisk.pl>
>> Acked-by: Kevin Hilman <khilman@ti.com>
>> ---
>>
>> Still awaiting some final testing here.  Rafael, was wondering if you
>> would be willing to ack this so we can merge it via the OMAP tree?
>> Otherwise the patch can be split into an OMAP part and a CPUFreq part that
>> can go in across two merge windows.
>>
> Hmm.
> I did similar change[1] a while back. Kevin didn't like idea though
> that point of time.

I was wrong.

At the time, we were thinking about how to get rid of clkdev nodes
instead of add more.  Now, we need to clean up these drivers and this is
the only way to do it, so I retract my objection.

Kevin
