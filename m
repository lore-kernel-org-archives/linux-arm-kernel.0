From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 29 Jan 2015 11:01:10 -0800
Subject: [PATCH 2/4] MAINTAINERS: update Broadcom Cygnus SoC git tree
In-Reply-To: <54B05AFD.2030105@broadcom.com>
References: <1420843541-5166-1-git-send-email-f.fainelli@gmail.com>
 <1420843541-5166-3-git-send-email-f.fainelli@gmail.com>
 <54B05AFD.2030105@broadcom.com>
Message-ID: <CAKdAkRSXYDdUxMVms4B53aV3fm=hkO3hnyHPhyzKGGW5Bxs4-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 9, 2015 at 2:49 PM, Ray Jui <rjui@broadcom.com> wrote:
>
>
> On 1/9/2015 2:45 PM, Florian Fainelli wrote:
>> The Cygnus SoC git tree is moved from github.com/brcm/linux.git to its
>> own git tree at github.com/Broadcom/cygnus-linux.git.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  MAINTAINERS | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index ff73215cd165..4a8f3459f9c2 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2192,7 +2192,7 @@ M:      Ray Jui <rjui@broadcom.com>
>>  M:   Scott Branden <sbranden@broadcom.com>
>>  L:   linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>>  L:   bcm-kernel-feedback-list at broadcom.com
>> -T:   git git://git.github.com/brcm/linux.git
>> +T:   git git://git.github.com/Broadcom/cygnus-linux.git
>
> Looks fine to me!

Hmm, the address does not work for me unless I drop 'git.' from the front:

git://github.com/Broadcom/cygnus-linux.git

Thanks.

-- 
Dmitry
