From: robdclark@gmail.com (Rob Clark)
Date: Wed, 15 Apr 2015 11:01:17 -0400
Subject: [RFC PATCH 0/5] Add smp booting support for Qualcomm ARMv8 SoCs
In-Reply-To: <20150415133403.GB26099@e104818-lin.cambridge.arm.com>
References: <1428601031-5366-1-git-send-email-galak@codeaurora.org>
 <20150410100529.GA6854@e104818-lin.cambridge.arm.com>
 <20150414163613.GM28709@leverpostej>
 <07185B2C-3F37-4E70-9096-1EF5EA8D68CE@codeaurora.org>
 <20150414211720.GA56647@MBP>
 <CAF6AEGtoxNrCoxT5n0CXmKMnL-YprJ3DkAuM4Myi87WMxPqBGw@mail.gmail.com>
 <20150415133403.GB26099@e104818-lin.cambridge.arm.com>
Message-ID: <CAF6AEGucYT4LHkFggR0fO_c7gZe7hD7STx1xwKrOvwsnnFbw7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 15, 2015 at 9:34 AM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Tue, Apr 14, 2015 at 05:48:48PM -0400, Rob Clark wrote:
>> Just speaking as an outsider to this topic, but seems like most/all
>> tablets/phones/etc ship with signed firmware.  Which means for most of
>> the population, upgrading the firmware to a new version which did
>> support the standard (assuming it existed), isn't really an option on
>> our devices, any more than fixing buggy acpi tables is on our
>> laptops..
>
> I wouldn't expect most population to build their own kernels on
> tablets/phones. And even if you could install a custom kernel, mainline
> rarely runs on such devices because of tons of out of tree patches (just
> look at the Nexus 9 patches that Kumar pointed at; even ignoring the
> booting protocol they are extremely far from an upstreamable form).
>

my point being, that it happens some times.. for example John Stultz's
work on nexus7:

https://plus.google.com/111524780435806926688/posts/DzvpMLmzQiQ

If this had been a year or two in the future and on some 64b
snapdragon, and support for devices with non-PSCI fw is rejected, then
he'd be stuck.

There are folks who are working to get saner, more-upstream kernels
working on devices.. and improving kernel infrastructure for
device-needs (well, in my neck of the woods, there is drm/kms atomic
and dsi/panel framework stuff.. I'm sure other similar things in other
kernel domains).  And it seems like that is a good thing to encourage,
rather than stymie.

BR,
-R

> --
> Catalin
