From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Thu, 17 Aug 2017 10:06:57 -0700
Subject: [GIT PULL 3/3] ARM: SOC: Keystone soc driver update for 4.14
In-Reply-To: <CAK8P3a2gj0nkdSmHYv=D+UWY1M48bacY4Cxy8T-Vu2cUqe2_Jw@mail.gmail.com>
References: <1502929842-8156-1-git-send-email-ssantosh@kernel.org>
 <1502929842-8156-3-git-send-email-ssantosh@kernel.org>
 <CAK8P3a2gj0nkdSmHYv=D+UWY1M48bacY4Cxy8T-Vu2cUqe2_Jw@mail.gmail.com>
Message-ID: <627dec90-71a7-be6c-d2bc-855e5bf552ae@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/17/2017 2:03 AM, Arnd Bergmann wrote:
> On Thu, Aug 17, 2017 at 2:30 AM, Santosh Shilimkar <ssantosh@kernel.org> wrote:
>> The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:
>>
>>    Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)
>>
>> are available in the git repository at:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone_soc_drivers_4.14
>>
>> for you to fetch changes up to a1934ff175ff25f57dae8b5107a2351d15729c3a:
>>
>>    soc: ti: ti_sci_pm_domains: Populate name for genpd (2017-07-28 09:51:34 -0700)
>>
>> ----------------------------------------------------------------
>> soc: Keystone ti-sci driver genpd fix for 4.14
> 
>  From the patch description I would have guessed that we want this in 4.13,
> can you clarify?
> 
I was in two minds as well but no one complained it has must have
fix so I just queued it for 4.14. If you can cherry pick that to 4.13,
that will be great.

Regards,
Santosh
