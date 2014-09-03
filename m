From: matt@console-pimps.org (Matt Fleming)
Date: Wed, 3 Sep 2014 13:07:51 +0100
Subject: [PATCH 3/5] x86: efi: format EFI memory type & attrs with
 efi_md_typeattr_format()
In-Reply-To: <1409532820-5027-4-git-send-email-lersek@redhat.com>
References: <1409532820-5027-1-git-send-email-lersek@redhat.com>
 <1409532820-5027-4-git-send-email-lersek@redhat.com>
Message-ID: <20140903120751.GC3001@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 01 Sep, at 02:53:38AM, Laszlo Ersek wrote:
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>  arch/x86/platform/efi/efi.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

I know this is a straight forward patch in the context of this series,
but you need to include a rationale, so that we know in 6 months, 12
months and 5 years from now why this change made sense.

Something like,

  "Reduce the amount of duplicated code by using the helper function"

would be fine.

-- 
Matt Fleming, Intel Open Source Technology Center
