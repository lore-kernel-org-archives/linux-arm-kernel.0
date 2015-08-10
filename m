From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Mon, 10 Aug 2015 13:59:13 +0200
Subject: [GIT PULL] STi DT changes for v4.3, round 1
In-Reply-To: <20150727122459.GB14224@localhost>
References: <55AFD16C.7020006@st.com> <20150727122459.GB14224@localhost>
Message-ID: <55C89211.8010600@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On 07/27/2015 02:24 PM, Olof Johansson wrote:
> On Wed, Jul 22, 2015 at 07:22:52PM +0200, Maxime Coquelin wrote:
>> Hi Olof, Arnd and Kevin,
>>
>> Please consider this first round of STi DT updates for v4.3:
>>
>> The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:
>>
>>    Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)
>>
>> are available in the git repository at:
>>
>>    https://git.kernel.org/pub/scm/linux/kernel/git/mcoquelin/sti.git
>> tags/sti-dt-for-v4.3-1
>>
>> for you to fetch changes up to 794445095791aa4f92dfd802f08b541167d63ecc:
>>
>>    ARM: DT: STiH410: Add bdisp dt nodes (2015-07-22 15:05:31 +0200)
> Thanks, merged, however:
>
>> Peter Griffin (11):
>>        ARM: STi: DT: Add STiH407 family tsin0 pinctrl configuration
>>        ARM: STi: DT: Add STiH407 family tsin1 pinctrl configuration
>>        ARM: STi: DT: Add STiH407 family tsin2 pinctrl configuration
>>        ARM: STi: DT: Add STiH407 family tsin3 pinctrl configuration
>>        ARM: STi: DT: Add STiH407 family tsin4 pinctrl configuration
>>        ARM: STi: DT: Add STiH407 family tsin5 pinctrl configuration
>>        ARM: STi: DT: Add STiH407 family tsout0 pinctrl configuration
>>        ARM: STi: DT: Add STiH407 family tsout1 pinctrl configuration
>>        ARM: STi: DT: Add STiH407 family mtsin0 pinctrl configuration
>>        ARM: STi: DT: STiH407: Add cpu-release-addr dt property.
>>        ARM: STi: DT: STiH418: Add cpu-release-addr dt property.
> The patch splitting here is a bit excessive. I think squashing these down
> into one to add STiH407 pinctrl configurations would have been just fine.
>
> Anyway, not a big deal.
>
>
Ok, I will avoid that next time.

Thanks!
Maxime
