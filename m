From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 6 Jan 2015 15:54:29 +0000
Subject: [PATCH v2 0/2] arm64: don't call early_*map() post paging_init()
In-Reply-To: <20150106155208.GC3827@bivouac.eciton.net>
References: <1420551673-31416-1-git-send-email-leif.lindholm@linaro.org>
 <20150106135941.GA3484@arm.com>
 <CAKv+Gu-nYC1VaJW6ULY0AantA681xZyxqqC+nQq91nj5t7w4OQ@mail.gmail.com>
 <20150106155208.GC3827@bivouac.eciton.net>
Message-ID: <CAKv+Gu9uWRmLBrnoUNsEcymguiUwgXUc8UVkLO0N21UywuGT=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 January 2015 at 15:52, Leif Lindholm <leif.lindholm@linaro.org> wrote:
> On Tue, Jan 06, 2015 at 02:04:50PM +0000, Ard Biesheuvel wrote:
>> >> Changes since v1:
>> >> - Rebased to v3.19-rc3
>> >> - Added 'Fixes:' tags
>> >> - Reworked 1/2 to restore call to efi_setup_idmap() to the original
>> >>   location in the boot process.
>> >
>> > Looks reasonable to me; do they need a CC stable,
>>
>> Yes, but with a note that both patches should be taken and the order
>> is retained, or we break bisect.
>
> Where would one add such a note?
>

I guess the best way would be to not add a 'Cc: stable' tag, but send
an email to Greg once the patches have been merged by Linus.

-- 
Ard.
