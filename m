From: panand@redhat.com (Pratyush Anand)
Date: Mon, 19 Dec 2016 12:53:17 +0530
Subject: [PATCH V2 1/2] kexec: arm64: create identity page table to be
 used in purgatory
In-Reply-To: <CAJGZr0Jg2ptdWGTDczOjdzDx6EkM5mOxWwKckWAZXvA9fzMpUg@mail.gmail.com>
References: <cover.1482129830.git.panand@redhat.com>
 <ea98a0045c8d466456f53150f341546810dd47e1.1482129830.git.panand@redhat.com>
 <CAJGZr0Jg2ptdWGTDczOjdzDx6EkM5mOxWwKckWAZXvA9fzMpUg@mail.gmail.com>
Message-ID: <c6efdafb-0521-6b9c-4f81-4f455d56be79@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 19 December 2016 12:51 PM, Maxim Uvarov wrote:
>> +
>> > +static void craete_block_entry(unsigned long *tbl, unsigned long flags,
> typo in name
>

Thanks.
Will fix.

~Pratyush
