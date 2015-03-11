From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 11 Mar 2015 13:56:34 +0000
Subject: [PATCH v2 1/3] arm64: KVM: Fix stage-2 PGD allocation to have
 per-page refcounting
In-Reply-To: <CAMJs5B_rXikZiLdWgwxdXYHcsyzo_Hm1T1Rm9Gkw12HPUvJ84A@mail.gmail.com>
References: <1426014421-5579-1-git-send-email-marc.zyngier@arm.com>	<1426014421-5579-2-git-send-email-marc.zyngier@arm.com>	<20150311121635.GA12888@cbox>	<55003F5F.6050706@arm.com>
 <CAMJs5B_rXikZiLdWgwxdXYHcsyzo_Hm1T1Rm9Gkw12HPUvJ84A@mail.gmail.com>
Message-ID: <55004992.5030908@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/03/15 13:20, Christoffer Dall wrote:
> On Wed, Mar 11, 2015 at 2:13 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:

>> Looks good to me. I'll fold that into the patch, amend the commit
>> message and resend.
>>
> 
> I've done that here:
> https://git.linaro.org/people/christoffer.dall/linux-kvm-arm.git/shortlog/refs/heads/pgd-fixes-alt
> 
> (except for the commit message, which I can also adjust).

Looks great, thanks.

> I gave this a quick spin on Juno and TC2 (but couldn't test 64K pages
> because I don't have a platform for that handy this very second)...

I can do that if you want.

	M.
-- 
Jazz is not dead. It just smells funny...
