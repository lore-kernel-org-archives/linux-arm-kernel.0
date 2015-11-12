From: schwab@suse.de (Andreas Schwab)
Date: Thu, 12 Nov 2015 14:47:18 +0100
Subject: [PATCH v6 13/17] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <16446627.b0Lo936ZJj@wuerfel> (Arnd Bergmann's message of "Thu,
 12 Nov 2015 14:24:57 +0100")
References: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
 <4796230.MStNPjWNEu@wuerfel> <mvmk2pny2js.fsf@hawking.suse.de>
 <16446627.b0Lo936ZJj@wuerfel>
Message-ID: <mvm4mgrxrbt.fsf@hawking.suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Thursday 12 November 2015 10:44:55 Andreas Schwab wrote:
>> Arnd Bergmann <arnd@arndb.de> writes:
>> 
>> > What do you mean with 32-bit off_t?
>> 
>> An ABI with 32-bit off_t, ie. all currently implemented 32-bit ABIs.
>> 
>> > Do you mean that glibc emulates a 32-bit off_t on top of the 64-bit
>> > __kernel_loff_t?
>> 
>> Glibc is bridging the user-space ABI to the kernel ABI.
>
> Ok, but why?

That's how the ABI is defined right now.  I didn't make that up.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab at suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
