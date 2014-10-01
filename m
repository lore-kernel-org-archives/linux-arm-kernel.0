From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Wed, 1 Oct 2014 18:12:20 +0200
Subject: [GIT PULL] ARM: STi: DT changes for v3.18
In-Reply-To: <201410011707.02238.arnd@arndb.de>
References: <54215982.2040909@st.com> <201410011707.02238.arnd@arndb.de>
Message-ID: <542C27E4.5070801@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/01/2014 05:07 PM, Arnd Bergmann wrote:
> On Tuesday 23 September 2014, Maxime Coquelin wrote:
>> Highlights:
>> -----------
>>   - Add SDHCI support for STiH41x B2020 boards
>>   - Add reset controllers to STiH407 SoC
>>   - Add MiPHY & SATA support to STiH416
>>   - Add Thermal supportto STiH416
>>   - Add Clock support to STiH407 SoC
>>
>> Note that this pull request contains merge from Philipp Zabel's reset tree for STiH407 reset DT bindings includes.
> 
> 
> Pulled into the next/late branch. If we end up sending a pull request for the
> late stuff this time, that also gives Philipp time to go first with his
> branches.

Ok, Philipp only has the STi patches in his branch for v3.18.
I think he didn't planned to send a pull request for it, expecting it would go through mine.

> 
> Unfortunately, your submission came a bit late, so no guarantee this is going
> to make it into 3.18. If we see too many regressions with the earlier branches,
> we'll defer it for 3.19.
Yes, I have been busy these days with other topics, but I thought it wasn't too late,
since it was two weeks before the opening of the merge window.

For next time, could tell me starting which -rc you consider it is too late?

Regards,
Maxime
> 
> 	Arnd
> 
