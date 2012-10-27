From: nsekhar@ti.com (Sekhar Nori)
Date: Sat, 27 Oct 2012 14:22:57 +0530
Subject: [PATCH v2 1/6] ARM: davinci: Changed pr_warning() to pr_warn()
In-Reply-To: <13514BD7FAEBA745BBD7D8A672905C14311F0E03@DFLE08.ent.ti.com>
References: <1351197357-23528-1-git-send-email-rtivy@ti.com>
 <508A5BF3.2060803@mvista.com>
 <13514BD7FAEBA745BBD7D8A672905C14311F0E03@DFLE08.ent.ti.com>
Message-ID: <508BA0E9.2050406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 10/27/2012 6:29 AM, Tivy, Robert wrote:
> Thanks for your comments, Sergei.  Please see below...
> 
>> -----Original Message-----
>> From: Sergei Shtylyov [mailto:sshtylyov at mvista.com]
>> Sent: Friday, October 26, 2012 2:46 AM
>> To: Tivy, Robert
>> Cc: davinci-linux-open-source at linux.davincidsp.com; linux-arm-
>> kernel at lists.infradead.org; Ring, Chris; Grosen, Mark; Nori, Sekhar
>> Subject: Re: [PATCH v2 1/6] ARM: davinci: Changed pr_warning() to
>> pr_warn()
>>
>> Hello.
>>
>>     It's not a good idea to send multiple patches with the same
>> subject.
>> Actually, in this case it's worth merging all 4 patches into one.
> 
> My first patch submission had them all as one patch, but Sekhar asked that they be split into 4 separate patches to make the merge easier.
> 
> I can make each one have a different subject, though.

Yes, it was I who asked for the patch to be separated out. My main
motivation was to keep board and soc file changes from mixing together.
The subject line for each patch should be different though.

> 
>>
>> On 26-10-2012 0:35, Robert Tivy wrote:
>>
>>> Also, while modifying those pr_warning() calls I changed hardcoded
>>> function names to use '"%s:", __func__' instead
>>
>>> Signed-off-by: Robert Tivy <rtivy@ti.com>
>>> ---
>>> Clean up files that will be otherwise modified in subsequent patch.
>>
>>> Applies to v3.5 tag (commit 28a33cbc24e4256c143dce96c7d93bf423229f92)
>> of
>>> Linus' mainline kernel at git.kernel.org.
>>
>>     3.5 is too old. Why not to 3.6 or even 3.7-rc2?
> 
> I will attempt to recreate this patch series on 3.7-rc2, although I will need to change it to use the newer "rproc" APIs and data structures.

All the more reason to rebase to v3.7-rc2!

Thanks,
Sekhar
