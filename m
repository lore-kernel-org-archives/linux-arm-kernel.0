From: michael.williamson@criticallink.com (Michael Williamson)
Date: Fri, 27 Aug 2010 07:12:57 -0400
Subject: [PATCH v4] davinci: Add MityDSP-L138/MityARM-1808 SOM support
In-Reply-To: <4C7702EB.8040905@criticallink.com>
References: <4C516634.5040804@criticallink.com>
	<877hjd106u.fsf@deeprootsystems.com>
	<4C7702EB.8040905@criticallink.com>
Message-ID: <4C779DB9.20107@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/26/2010 08:12 PM, Michael Williamson wrote:
> Hi Kevin,
>
> On 08/26/2010 06:25 PM, Kevin Hilman wrote:
>> Michael Williamson<michael.williamson@criticallink.com>  writes:
>>
>>>   This patch adds support for the MityDSP-L138 and MityARM-1808 
>>> system on
>>> module (SOM) under the registered machine "mityomapl138".  These SOMs
>>> are based on the da850 davinci CPU architecture.  Information on these
>>> SOMs may be found at http://www.mitydsp.com.
>>>
>>> Signed-off-by: Michael Williamson<michael.williamson@criticallink.com>
>>> ---
>>> This patch is against Kevin's tree, but is dependent on the 
>>> following patch,
>>> which is queued for 2.6.36:
>>>
>>> [1] 
>>> http://git.kernel.org/?p=linux/kernel/git/broonie/sound-2.6.git;a=commit;h=48519f0ae03bc7e86b3dc93e56f1334d53803770 
>>>
>> Running this patch through scripts/checkpatch.pl, I get:
>>
>>     total: 268 errors, 586 warnings, 1632 lines checked
>>
>> Please fix all errors and warnings.
>>
>> For future reference, normally, I don't even read the rest of a patch if
>> there are any checkpatch errors.
>>
>
> As expected. At the time I submitted this (before your comments came in
> on V3, actually), I had run a checkpatch.pl and it had passed.  That was
> prior to the 2.6.35 merge when you got back from vacation.
That should have read 2.6.36.  I also must have blown the checkpatch as 
well.

-Mike
