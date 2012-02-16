From: chaoys155@gmail.com (=?UTF-8?B?5pmB5rC455Sf?=)
Date: Thu, 16 Feb 2012 18:33:52 +0800
Subject: Question: how to make one page readonly on ARM
In-Reply-To: <20120216085537.GJ13673@n2100.arm.linux.org.uk>
References: <CAADzPW2bW8Rx+V726L+Mfji+-+rFxwwYO0nkKtgMTM0XtQ7BpQ@mail.gmail.com>
 <20120216085537.GJ13673@n2100.arm.linux.org.uk>
Message-ID: <CAADzPW3FvBrupA-Vocdk6Xxn_2y4_3ar57wPTLft5H3FgEHP7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/2/16 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Thu, Feb 16, 2012 at 12:54:27PM +0800, ??? wrote:
>> Hi,
>> I get one page by __get_free_page and can make it readonly by
>> set_memory_ro on X86,
>> but how to do this on ARM?
>
> You can't, because we map all kernel space with 1MB section mappings.

sorry, I don't quite understand. I am kernel newbie.
Do you mean that if I want to make one memory region readonly, it has
to be in MB unit?
Does ARM kernel have any functions similar to set_memory_ro?

-- 
Thanks a lot!
