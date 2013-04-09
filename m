From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 09 Apr 2013 09:37:30 +0100
Subject: [PATCH 1/2] ARM: KVM: add architecture specific hook for
 capabilities
In-Reply-To: <CAFEAcA-WQO7cdi25-Bu5Yj3yN0PgUmEezHpdhR7dfQ_2y+Z0vg@mail.gmail.com>
References: <1365436039-29564-1-git-send-email-marc.zyngier@arm.com>
 <1365436039-29564-2-git-send-email-marc.zyngier@arm.com>
 <CAFEAcA-WQO7cdi25-Bu5Yj3yN0PgUmEezHpdhR7dfQ_2y+Z0vg@mail.gmail.com>
Message-ID: <5163D34A.8010906@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/04/13 16:53, Peter Maydell wrote:
> On 8 April 2013 16:47, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> Most of the capabilities are common to both arm and arm64, but
>> we still need to handle the exceptions.
>>
>> Introduce kvm_arch_dev_ioctl_check_extention, which both architectures
> 
> "extension" (here and in the code itself).

Damn. My native language has crept back. Thanks for pointing it out.

	M.
-- 
Jazz is not dead. It just smells funny...
