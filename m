From: arno@natisbad.org (Arnaud Ebalard)
Date: Fri, 17 Jan 2014 07:25:08 +0100
Subject: [BUG] FL1009: xHCI host not responding to stop endpoint command.
In-Reply-To: <20140116185044.GC18392@xanatos> (Sarah Sharp's message of "Thu,
 16 Jan 2014 10:50:44 -0800")
References: <87eh4dot61.fsf@natisbad.org> <87sissopaf.fsf@natisbad.org>
 <20140114170719.GA12126@xanatos> <87bnzekz5l.fsf@natisbad.org>
 <063D6719AE5E284EB5DD2968C1650D6D45C5AB@AcuExch.aculab.com>
 <87mwix5anm.fsf@natisbad.org> <20140116185044.GC18392@xanatos>
Message-ID: <87fvon2khn.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sarah Sharp <sarah.a.sharp@linux.intel.com> writes:

>> ... AFAICT, this is exactly what commit 35773dac5f86 does and reverting
>> it does not help. If I am mistaken, can you point which part you want me
>> to remove in the code to test?
>> 
>> I am slowly starting to see a bisect session coming ;-)
>
> Try reverting commit 60e102ac73cd40069d077014c93c86dc7205cb68.

AFAICT, this commit does not exist in master (Linus tree), i.e. it is
not in 3.13.0-rc8.

> That was causing issues with another Fresco Logic host.  If that
> doesn't help, then yes, please git bisect.

I have started a bisect session yesterday. I will try and finish it this
evening.

Cheers,

a+
