From: olof@lixom.net (Olof Johansson)
Date: Fri, 24 Aug 2018 08:29:44 -0700
Subject: Reset controller fixes for v4.18
In-Reply-To: <1533728841.19096.4.camel@pengutronix.de>
References: <1533551833.4204.10.camel@pengutronix.de>
 <1533728841.19096.4.camel@pengutronix.de>
Message-ID: <CAOesGMj+vSb+hBH3JFFU_gp5c6LiyJDgnrCPT2ksHWd6-=ACPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 8, 2018 at 4:47 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> On Mon, 2018-08-06 at 12:37 +0200, Philipp Zabel wrote:
>> Dear arm-soc maintainers,
>>
>> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
>>
>>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
>>
>> are available in the git repository at:
>>
>>   git://git.pengutronix.de/git/pza/linux.git tags/reset-fixes-for-4.18
>>
>> for you to fetch changes up to 26fce0557fa639fb7bbc33e31a57cff7df25c3a0:
>>
>>   reset: imx7: Fix always writing bits as 0 (2018-07-23 13:00:28 +0200)
>>
>> ----------------------------------------------------------------
>> Reset controller fixes for v4.18
>>
>> This tag fixes reset assertion on i.MX7 for all non-inverted reset
>> control bits. Currently only PCIE controller and PHY resets are used.
>>
>> ----------------------------------------------------------------
>> Leonard Crestez (1):
>>       reset: imx7: Fix always writing bits as 0
>>
>>  drivers/reset/reset-imx7.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> I've resent the pull requests with the missing [GIT PULL] tag added,
> sorry for the noise.

No worries. This came in very close to the close of the release and I
foolishly held on waiting for more fixes instead of merging. I've done
so now, this will go in with the rest of the late code for the merge
window. It'll have to go to 4.18 through -stable.


Thanks,

-Olof
