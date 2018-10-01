From: john.stultz@linaro.org (John Stultz)
Date: Mon, 1 Oct 2018 14:28:04 -0700
Subject: RESEND and REBASE arm+arm64+aarch32 vdso rewrite
In-Reply-To: <8c09a380-7bc8-a353-aeb7-6591e6c57f68@android.com>
References: <20181001175845.168430-1-salyzyn@android.com>
 <CALAqxLWCbw0bmYeB9Vfi5wXJcnLRnE0TYxy1h5WkHLehHv8KFg@mail.gmail.com>
 <8c09a380-7bc8-a353-aeb7-6591e6c57f68@android.com>
Message-ID: <CALAqxLVGx_GhqHZbPoVExOehCD8f5s4LfXZx5DTvSuiErCCa3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 1, 2018 at 1:44 PM, Mark Salyzyn <salyzyn@android.com> wrote:
> On 10/01/2018 11:49 AM, John Stultz wrote:
>> It seems the patchset is already somewhat broken up into separate
>> sets, so I might recommend picking just one area and focus on
>> upstreaming that first. Maybe the in-arch cleanups for arm and then
>> arm64 and then maybe do the move to lib?
>
>
> They are in set-order, The first 12 can be taken one at a time to modernize
> arm so that it is up-to-date with the assembler code for arm64. More or less
> the order you just outlined.
>
> TahDah :-)

Sorry, I appreciate the background. I know this has been something
you've been pushing for quite some time, but it also seems to be
somewhat sporadic, and that makes it hard to keep track of the
narrative.

I'm unfortunately not the right person to queue the arm/arm64 changes,
but let me know if I can help with the generic bits.

thanks
-john
