From: laurentiu.tudor@nxp.com (Laurentiu Tudor)
Date: Fri, 26 May 2017 13:19:53 +0000
Subject: [PATCH 1/5][v2] staging: fsl-mc: fix several checkpath.pl warnings
In-Reply-To: <20170525165844.GA8812@kroah.com>
References: <20170522120935.4119-1-laurentiu.tudor@nxp.com>
 <20170522120935.4119-2-laurentiu.tudor@nxp.com>
 <20170525165844.GA8812@kroah.com>
Message-ID: <59282B78.1010709@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On 05/25/2017 07:58 PM, Greg KH wrote:
> On Mon, May 22, 2017 at 03:09:31PM +0300, laurentiu.tudor at nxp.com wrote:
>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>
> Your subject line is very odd, please use the 'v2' marking properly...
>
>>
>> Remove several unneeded #includes, forward
>> declarations and fix several issues reported
>> by checkpatch.pl --strict, such as:
>>   - kfree(NULL) is safe and check is not required
>>   - macro argument reuse may cause possible side effects
>>   - enclose macro params in parens to avoid precedence issues
>>   - coding style
>
> These, as always, need to be broken up into one-patch-per-type-of-thing,
> you have been in the staging tree long enough to know this :(

Sorry about that. Will take care of all your comments in the next respin.

---
Thanks & Best Regards, Laurentiu
