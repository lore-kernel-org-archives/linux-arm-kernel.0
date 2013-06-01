From: olof@lixom.net (Olof Johansson)
Date: Fri, 31 May 2013 22:36:58 -0700
Subject: [GIT PULL] ARM: mvebu: cleanup for v3.11 (round 3 cumulative)
In-Reply-To: <20130601053605.GH5189@quad.lixom.net>
References: <20130528183422.GA31290@titan.lakedaemon.net>
 <20130601053605.GH5189@quad.lixom.net>
Message-ID: <CAOesGMgpRz_dQcurz1VxtwnqumaMZHT8voiwY6=F4vOFKU-r6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 31, 2013 at 10:36 PM, Olof Johansson <olof@lixom.net> wrote:
> Hi Jason,
>
> On Tue, May 28, 2013 at 02:34:22PM -0400, Jason Cooper wrote:
>> Olof,
>>
>> This is the latest for cleanup, and the summary includes everything so
>> far for this window.
>>
>>
>> The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:
>>
>>   Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)
>>
>> are available in the git repository at:
>>
>>   git://git.infradead.org/users/jcooper/linux.git tags/cleanup-3.11-3
>>
>
> Something odd is going on here.
>
>> for you to fetch changes up to c589f9b4b51317cfc530812fe90a9895bd51430e:
>>
>>   arm: mvebu: mark functions of armada-370-xp.c as static (2013-05-21 13:44:32 +0000)
>>
>> ----------------------------------------------------------------
>> mvebu cleanup for v3.11 (round 3)
>>
>>  - mvebu
>>     - mark functions in armada-370-xp.c as static
>>
>> ----------------------------------------------------------------
>> Andrew Lunn (1):
>>       ARM: Orion: Remove redundant init_dma_coherent_pool_size()
>>
>> Maxime Ripard (1):
>>       ARM: mvebu: Remove init_irq declaration in machine description
>>
>> Thomas Petazzoni (1):
>>       arm: mvebu: mark functions of armada-370-xp.c as static
>>
>>  arch/arm/mach-kirkwood/common.c     |  6 ------
>>  arch/arm/mach-mvebu/armada-370-xp.c | 15 +++------------
>>  arch/arm/mach-orion5x/common.c      |  7 -------
>>  3 files changed, 3 insertions(+), 25 deletions(-)
>
> Two of the above patches are already in mainline, so the diffstat don't match.
>
> Did you base your cleanup branch on your previous fixes branch, and not take
> that into consideration when you generated the pull request? Can you fix your
> scripts to do so, please?


By the way, I have already pulled it in anyway after inspection of the delta.


-Olof
