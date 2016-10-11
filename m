From: mbrugger@suse.com (Matthias Brugger)
Date: Tue, 11 Oct 2016 12:20:41 +0200
Subject: [PATCH 0/2] arm64 kexec-tools fixups
In-Reply-To: <cover.1476134309.git.geoff@infradead.org>
References: <cover.1476134309.git.geoff@infradead.org>
Message-ID: <ebe32436-6069-06c5-702f-d435d0dacd48@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/10/2016 11:22 PM, Geoff Levand wrote:
> Hi Simon,
>
> Fixes for 'make tarball'.  Please apply.
>
> -Geoff
>
> The following changes since commit 6e8804f9ca67bee65aedd5e1cdf504737ab5c7ed:
>
>   multiboot: Use the "reserved" type for non-ram zones (2016-10-07 11:54:44 +0900)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/geoff/kexec-tools.git for-merge-arm64-dist
>
> for you to fetch changes up to 3552a3e85a910688d932535549b35354a54927ad:
>
>   arm64: Add missing kexec dist files (2016-10-10 14:15:21 -0700)
>
> ----------------------------------------------------------------
> Geoff Levand (2):
>       arm64: Cleanup kexec Makefile
>       arm64: Add missing kexec dist files
>
>  kexec/arch/arm64/Makefile | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>
