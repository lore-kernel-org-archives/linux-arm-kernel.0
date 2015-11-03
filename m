From: keescook@chromium.org (Kees Cook)
Date: Tue, 3 Nov 2015 15:21:12 -0800
Subject: [PATCH v2 2/2] arm: mm: support ARCH_MMAP_RND_BITS.
In-Reply-To: <56393FD0.6080001@android.com>
References: <1446574204-15567-1-git-send-email-dcashman@android.com>
 <1446574204-15567-2-git-send-email-dcashman@android.com>
 <CAGXu5jKGzDD9WVQnMTT2EfupZtjpdcASUpx-3npLAB-FctLodA@mail.gmail.com>
 <56393FD0.6080001@android.com>
Message-ID: <CAGXu5jLe=OgZ2DG_MRXA8x6BwpEd77fNZBj3wjbDiSdiBurz7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 3, 2015 at 3:14 PM, Daniel Cashman <dcashman@android.com> wrote:
> On 11/03/2015 11:19 AM, Kees Cook wrote:
>> Do you have patches for x86 and arm64?
>
> I was holding off on those until I could gauge upstream reception.  If
> desired, I could put those together and add them as [PATCH 3/4] and
> [PATCH 4/4].

If they're as trivial as I'm hoping, yeah, let's toss them in now. If
not, skip 'em. PowerPC, MIPS, and s390 should be relatively simple
too, but one or two of those have somewhat stranger calculations when
I looked, so their Kconfigs may not be as clean.

-Kees

-- 
Kees Cook
Chrome OS Security
