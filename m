From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 12 Dec 2013 10:11:23 +0800
Subject: [GIT PULL][for 3.14] pull request from pxa
In-Reply-To: <20131212012928.GA22922@quad.lixom.net>
References: <52A823E4.6070208@gmail.com>
 <20131212012928.GA22922@quad.lixom.net>
Message-ID: <52A91B4B.2050907@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2013 09:29 AM, Olof Johansson wrote:
> On Wed, Dec 11, 2013 at 04:35:48PM +0800, Haojian Zhuang wrote:
>> Hi Arnd/Olof/Kevin,
>>
>> Please help to merge the pull request for pxa.
>>
>>
>> Best Regards
>> Haojian
>>
>> The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:
>>
>>    Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)
>>
>> are available in the git repository at:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/hzhuang1/linux.git
>> tags/pxa-for-3.14
>>
>> for you to fetch changes up to 8a53a1194f1cc870de0ab9db1728b1ecab770925:
>>
>>    ARM: pxa: remove IRQF_DISABLED (2013-12-11 15:36:24 +0800)
>>
>> ----------------------------------------------------------------
>> Dmitry Eremin-Solenikov (1):
>>        arm: pxa: tosa: fix keys mapping
>>
>> Michael Opdenacker (1):
>>        ARM: pxa: remove IRQF_DISABLED
>
> This patch doesn't even build:
>
> arch/arm/mach-pxa/pcm990-baseboard.c:331:9: error: too few arguments to
> function 'request_irq'
>
> Why the !@%@# are you sending me code for your platform that you didn't
> even bother building to check for errors?
>
> I've fixed it up, but you really have to do better than this.
>
>
> -Olof
>

I'm sorry on this. I'll be careful in the future.

Best Regards
Haojian
