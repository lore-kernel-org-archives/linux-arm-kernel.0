From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 26 Apr 2016 13:34:06 +0200
Subject: [PATCH v2 0/6] arm64/ARM pt dumper changes
In-Reply-To: <20160426112918.GK27312@arm.com>
References: <1461343688-8552-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160426112918.GK27312@arm.com>
Message-ID: <CAKv+Gu9h4r1ypiUo23ZGw=rF_NqLwWybwrhT-1gyAE9TYhN0zA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 April 2016 at 13:29, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Apr 22, 2016 at 06:48:02PM +0200, Ard Biesheuvel wrote:
>> This series updates the kernel page table dumper to:
>> - not initialize the vmemmap region markers dynamically
>> - show region boundaries for the kasan shadow region
>> - include the UEFI runtime services mappings
>
> I've merged the first two patches of this series. I can take patch 4 too
> if you can rebase onto for-next/core.
>

Thanks, but it is not very useful without the last patch. I am trying
to respin the code so it can be shared between ARM and arm64 in a way
that addresses Mark's concerns. But since this is debug code anyway, I
am not sure when I will get around to doing that.

Thanks,
Ard.
