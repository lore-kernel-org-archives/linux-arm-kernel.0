From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 7 Jan 2012 14:33:16 +0000
Subject: the bug of free_memmap
In-Reply-To: <CAN-V0CA+B9k-EQ72mafN6w8zhBGsa2EXy1EropaHtAaZRMSK9g@mail.gmail.com>
References: <CAN-V0CA+B9k-EQ72mafN6w8zhBGsa2EXy1EropaHtAaZRMSK9g@mail.gmail.com>
Message-ID: <CAHkRjk7zoKqm0uOiP3qMELeA6UTij8TOM18QkjAL8VeDRKV4LA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 January 2012 14:05, Hu Ruihuan <specter118@gmail.com> wrote:
> ? ?I have fount a bug in free_memmap function. When using sparsemem,
> and just a memory section is in a hole, the start_pfn parameter of
> free_memmap will be the last page of the section forward. Then the
> start_pg will be the address of the last page of the section forward
> plus the size of struct page, not the right one.

I don't fully get what the problem is. Is this with the latest kernel?
Could you please provide an example of your memory banks layout?

-- 
Catalin
