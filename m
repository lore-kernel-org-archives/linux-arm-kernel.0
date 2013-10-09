From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 09 Oct 2013 09:10:25 +0200
Subject: New big-endian patch series against 3.12-rc4
In-Reply-To: <CAA3XUr31CON02T66_nrV-PsrjyLgzCbXC2WokQeC58z6APAbVQ@mail.gmail.com>
References: <1381271679-27804-1-git-send-email-ben.dooks@codethink.co.uk>
 <CAA3XUr31CON02T66_nrV-PsrjyLgzCbXC2WokQeC58z6APAbVQ@mail.gmail.com>
Message-ID: <52550161.2030406@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/13 08:20, Victor Kamensky wrote:
> Hi Ben,
>
> On 8 October 2013 15:34, Ben Dooks<ben.dooks@codethink.co.uk>  wrote:
>> This is a new series for big-endian on ARM re-based onto 3.12-rc4
>> and updated with new patches from Victor to fix regressions since 3.11.
>>
>> I have not been able to test this further than building it as I do not
>> currently have access to any hardware, however there where no big issues
>> when re-basing. Thanks to Marc Zyngier for pointing out the need for a
>> rebase.
>>
>> The branch is at:
>>
>>    git://git.baserock.org/delta/linux baserock/bjdooks/3.12-rc4/core
>
> It is rather baserock/312-rc4/be/core isn't it?
>
> I've tested baserock/312-rc4/be/core from
> git://git.baserock.org/delta/linux on TC2. Both LE and BE images.
> Done full LTP runs on both. LTP BE results match LE one.

Thanks, yes the path was wrong.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
