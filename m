From: bgamari.foss@gmail.com (Ben Gamari)
Date: Tue, 19 Nov 2013 12:51:21 -0500
Subject: cpufreq on PandaBoard
In-Reply-To: <528BA031.5050201@ti.com>
References: <87eh6ca150.fsf@gmail.com> <528B7D61.5020206@ti.com>
 <87hab8nwdl.fsf@gmail.com> <528BA031.5050201@ti.com>
Message-ID: <87bo1gnuue.fsf@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nishanth Menon <nm@ti.com> writes:

> On 11/19/2013 11:18 AM, Ben Gamari wrote:
>> 
>> I take it that the clock node work does not itself fix cpufreq? I've
>> built the 3.12-dt-clks-v10-dev branch. On the bright side, it boots and
>> appears to run just fine. Unfortunately, there isn't even a mention of
>> cpufreq in the boot log.
>
> You are probably picking up a branch that is yet to be posted :)...
> and I assume you know the risk of in-development patches ;)
> 
The house hasn't burned down yet... ;)

> - the branch looks to introduce purely clock nodes which patch [2]
> adds on to and makes cpufreq work as a start..
>
Thanks!

>> 
>> I've seen your Google+ post[1] from May enumerating the steps to having
>> working DVFS. It would be useful to post an update showing what has been
>> merged, what is waiting for merge, and what is still in progress.
>
> We are still at "step 1 - get clock nodes" :(... and no, situation has
> not improved since May 2013 when I originally posted that G+ comment
> (and not because we have not been trying..).
>
Ouch. Good luck! 

>> I wasn't asking for official support, just wondering where work is
>> currently happening.
>
> they are happening here in linux-omap mailing list.. just that the
> changes are pretty fundamental and a lot of discussions have been
> taking place
> 
Thanks!

Cheers,

- Ben
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 489 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131119/f655addd/attachment.sig>
