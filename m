From: dcashman@android.com (Daniel Cashman)
Date: Wed, 4 Nov 2015 10:30:52 -0800
Subject: [PATCH v2 2/2] arm: mm: support ARCH_MMAP_RND_BITS.
In-Reply-To: <CAGXu5jLe=OgZ2DG_MRXA8x6BwpEd77fNZBj3wjbDiSdiBurz7w@mail.gmail.com>
References: <1446574204-15567-1-git-send-email-dcashman@android.com>
 <1446574204-15567-2-git-send-email-dcashman@android.com>
 <CAGXu5jKGzDD9WVQnMTT2EfupZtjpdcASUpx-3npLAB-FctLodA@mail.gmail.com>
 <56393FD0.6080001@android.com>
 <CAGXu5jLe=OgZ2DG_MRXA8x6BwpEd77fNZBj3wjbDiSdiBurz7w@mail.gmail.com>
Message-ID: <563A4EDC.6090403@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/3/15 3:21 PM, Kees Cook wrote:
> On Tue, Nov 3, 2015 at 3:14 PM, Daniel Cashman <dcashman@android.com> wrote:
>> On 11/03/2015 11:19 AM, Kees Cook wrote:
>>> Do you have patches for x86 and arm64?
>>
>> I was holding off on those until I could gauge upstream reception.  If
>> desired, I could put those together and add them as [PATCH 3/4] and
>> [PATCH 4/4].
> 
> If they're as trivial as I'm hoping, yeah, let's toss them in now. If
> not, skip 'em. PowerPC, MIPS, and s390 should be relatively simple
> too, but one or two of those have somewhat stranger calculations when
> I looked, so their Kconfigs may not be as clean.

Creating the patches should be simple, it's the choice of minimum and
maximum values for each architecture that I'd be most concerned about.
I'll put them together, though, and the ranges can be changed following
discussion with those more knowledgeable, if needed.  I also don't have
devices on which to test the PowerPC, MIPS and s390 changes, so I'll
need someone's help for that.

Thank You,
Dan
