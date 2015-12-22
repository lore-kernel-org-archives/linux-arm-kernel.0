From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Dec 2015 12:31:31 +0000
Subject: [GIT PULL] UEFI support for 32-bit ARM
In-Reply-To: <CAKv+Gu_Bd4NyC3u96Un-JdzOcaKvsFadEwp06qHAF7xPMyLQ0w@mail.gmail.com>
References: <CAKv+Gu_QvQnsYk=coEJQrRk94xATT9Fi5=9jCZhLoNUvTU7kJg@mail.gmail.com>
 <CAKv+Gu_Bd4NyC3u96Un-JdzOcaKvsFadEwp06qHAF7xPMyLQ0w@mail.gmail.com>
Message-ID: <20151222123131.GF8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2015 at 01:21:12PM +0100, Ard Biesheuvel wrote:
> On 14 December 2015 at 18:10, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > Hello all,
> >
> > NOTE: this pull request is based on a stable, shared branch published
> > by the arm64 maintainers. This means that pulling the
> > arm32-efi-for-v4.5 tag will pull the following patches along with the
> > patches listed below:
> >
> > f7d924894265 arm64/efi: refactor EFI init and runtime code for reuse
> > by 32-bit ARM
> > e5bc22a42e4d arm64/efi: split off EFI init and runtime code for reuse
> > by 32-bit ARM
> > 4dffbfc48d65 arm64/efi: mark UEFI reserved regions as MEMBLOCK_NOMAP
> > 68709f45385a arm64: only consider memblocks with NOMAP cleared for
> > linear mapping
> > bf3d3cc580f9 mm/memblock: add MEMBLOCK_NOMAP attribute to memblock memory table
> >
> > @Will: please advise when you intend to send these to -next. Thanks.
> >
> 
> Russell,
> 
> Could you please indicate whether or not, and when you intend to pull
> these changes?
> 
> All prerequisites are in, including the arm64 changes that Will has
> queued for 4.5

Thanks for the reminder.  It didn't show up as a pull request for me
because it was addressed to rmk+pull not linux+pull as I had requested
pull requests to be.

linux+pull marks the message with a red background so it stands out
my the mailbox.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
