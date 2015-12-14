From: will.deacon@arm.com (Will Deacon)
Date: Mon, 14 Dec 2015 17:18:17 +0000
Subject: [GIT PULL] UEFI support for 32-bit ARM
In-Reply-To: <CAKv+Gu_QvQnsYk=coEJQrRk94xATT9Fi5=9jCZhLoNUvTU7kJg@mail.gmail.com>
References: <CAKv+Gu_QvQnsYk=coEJQrRk94xATT9Fi5=9jCZhLoNUvTU7kJg@mail.gmail.com>
Message-ID: <20151214171816.GA3713@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2015 at 06:10:12PM +0100, Ard Biesheuvel wrote:
> NOTE: this pull request is based on a stable, shared branch published
> by the arm64 maintainers. This means that pulling the
> arm32-efi-for-v4.5 tag will pull the following patches along with the
> patches listed below:
> 
> f7d924894265 arm64/efi: refactor EFI init and runtime code for reuse
> by 32-bit ARM
> e5bc22a42e4d arm64/efi: split off EFI init and runtime code for reuse
> by 32-bit ARM
> 4dffbfc48d65 arm64/efi: mark UEFI reserved regions as MEMBLOCK_NOMAP
> 68709f45385a arm64: only consider memblocks with NOMAP cleared for
> linear mapping
> bf3d3cc580f9 mm/memblock: add MEMBLOCK_NOMAP attribute to memblock memory table
> 
> @Will: please advise when you intend to send these to -next. Thanks.

I'll merge that branch into for-next/core today or tomorrow, so it will
appear in -next shortly after that.

Will
