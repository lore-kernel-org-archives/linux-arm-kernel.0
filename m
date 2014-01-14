From: bjorn@mork.no (=?utf-8?Q?Bj=C3=B8rn_Mork?=)
Date: Tue, 14 Jan 2014 19:11:49 +0100
Subject: [BUG] FL1009: xHCI host not responding to stop endpoint command.
In-Reply-To: <20140114170719.GA12126@xanatos> (Sarah Sharp's message of "Tue,
 14 Jan 2014 09:07:19 -0800")
References: <87eh4dot61.fsf@natisbad.org> <87sissopaf.fsf@natisbad.org>
 <20140114170719.GA12126@xanatos>
Message-ID: <87r48a77ru.fsf@nemi.mork.no>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sarah Sharp <sarah.a.sharp@linux.intel.com> writes:
> On Sun, Jan 12, 2014 at 10:36:56PM +0100, Arnaud Ebalard wrote:
>
>> arno at natisbad.org (Arnaud Ebalard) writes:
>> 
>> 2) on current 3.13.0-rc7 kernel (w/ Bj?rn patch applied just in case), I
>
> Which patch are you referring to?

I wondered about that too at first :-)

But luckily I don't work that much, and the reference to the ASIX
AX88179 made it clearer.  I believe it must have been this patch:

 https://git.kernel.org/cgit/linux/kernel/git/davem/net.git/commit/?id=fdc3452cd2c7b2bfe0f378f92123f4f9a98fa2bd


Bj?rn
