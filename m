From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Mon, 30 Oct 2017 10:37:09 -0700
Subject: [GIT PULL 2/3] ARM: Keystone config update for 4.15
In-Reply-To: <CAK8P3a21yh17EGnh5+hL46TVyoOn0HN1zUoJNVxsMYGfOCUntQ@mail.gmail.com>
References: <1508548966-7350-1-git-send-email-santosh.shilimkar@oracle.com>
 <1508548966-7350-2-git-send-email-santosh.shilimkar@oracle.com>
 <CAK8P3a1BU6U_c+a0nTp7QM2-AR6qh-3T+RaGQX4mLvUU8Lg62Q@mail.gmail.com>
 <68f47a4e-ba33-ff33-3c73-9b104284f1a8@oracle.com>
 <CAK8P3a21yh17EGnh5+hL46TVyoOn0HN1zUoJNVxsMYGfOCUntQ@mail.gmail.com>
Message-ID: <fc8c61fb-42b2-5db5-b45a-22e8246a4577@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/30/17 10:04 AM, Arnd Bergmann wrote:
> On Mon, Oct 30, 2017 at 4:28 PM, Santosh Shilimkar
> <santosh.shilimkar@oracle.com> wrote:
>> On 10/30/2017 3:01 AM, Arnd Bergmann wrote:
>>>
>>> On Sat, Oct 21, 2017 at 3:22 AM, Santosh Shilimkar
>>> <santosh.shilimkar@oracle.com> wrote:
>>>>
>>>> The following changes since commit
>>>> e19b205be43d11bff638cad4487008c48d21c103:
>>>>
>>>>     Linux 4.14-rc2 (2017-09-24 16:38:56 -0700)
>>>>
>>>> are available in the git repository at:
>>>>
>>>>
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git
>>>> tags/keystone_config_4.15
>>>>
>>>> for you to fetch changes up to fc88a0631ed0f5b1862d42fb8f2455bf3d18744b:
>>>>
>>>>     ARM: configs: keystone: Enable TIECAP PWM driver (2017-10-09 09:43:32
>>>> -0700)
>>>
>>>
>>> Pulled into next/soc. Should this also be enabled in multi_v7_defconfig?
>>>
>> Sure !!
> 
> Can you send a patch for that then? Ideally, you could go through all options
> that are enabled in keystone_defconfig but not multi_v7_defconfig and see
> if we want to enable them too (as modules if possible). Feel free to just send
> a single patch describing what you found rather than a pull request.
> 
Will do.
