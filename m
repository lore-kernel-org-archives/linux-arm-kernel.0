From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Tue, 6 Jan 2015 15:52:08 +0000
Subject: [PATCH v2 0/2] arm64: don't call early_*map() post paging_init()
In-Reply-To: <CAKv+Gu-nYC1VaJW6ULY0AantA681xZyxqqC+nQq91nj5t7w4OQ@mail.gmail.com>
References: <1420551673-31416-1-git-send-email-leif.lindholm@linaro.org>
 <20150106135941.GA3484@arm.com>
 <CAKv+Gu-nYC1VaJW6ULY0AantA681xZyxqqC+nQq91nj5t7w4OQ@mail.gmail.com>
Message-ID: <20150106155208.GC3827@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 06, 2015 at 02:04:50PM +0000, Ard Biesheuvel wrote:
> >> Changes since v1:
> >> - Rebased to v3.19-rc3
> >> - Added 'Fixes:' tags
> >> - Reworked 1/2 to restore call to efi_setup_idmap() to the original
> >>   location in the boot process.
> >
> > Looks reasonable to me; do they need a CC stable,
> 
> Yes, but with a note that both patches should be taken and the order
> is retained, or we break bisect.

Where would one add such a note?

/
    Leif
