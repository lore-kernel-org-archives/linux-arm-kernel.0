From: b-cousson@ti.com (Benoit Cousson)
Date: Thu, 28 Mar 2013 16:49:20 +0100
Subject: [PATCH V2 0/8] ARM: OMAP3+: support cpufreq-cpu0 for device tree
 boot
In-Reply-To: <CAGo_u6rn=GHVfJiz_7gkse2e-e3BZicEqJBQWomftpi-nCvfng@mail.gmail.com>
References: <1363715590-5131-1-git-send-email-nm@ti.com>
 <51542390.1020300@ti.com>
 <CAGo_u6rn=GHVfJiz_7gkse2e-e3BZicEqJBQWomftpi-nCvfng@mail.gmail.com>
Message-ID: <51546680.5080107@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/28/2013 02:43 PM, Nishanth Menon wrote:
> Hi Benoit,
> 
> On Thu, Mar 28, 2013 at 6:03 AM, Benoit Cousson <b-cousson@ti.com> wrote:
>> The patches 1 to 6 looks good to me. Beside the pretty long Cc list,
>> that should not necessarily contain all the mailing list.
> Arrgh.. my bad. I will keep it in mind for the future.
> 
>>
>> Since you are changing / renaming some DTS files, and to avoid any merge
>> conflict I will apply only these 6 patches.
>> DTS and driver changes are in theory orthogonal enough to allow merging
>> them separately and in any order.
>>
>> I'll update my branch with these patches ASAP.
> Thanks. I will post a v3 of remaining patches later today.

Patches after changelog cleanup are available in the following branch:

git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.10/dts

Regards,
Benoit
