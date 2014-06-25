From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Wed, 25 Jun 2014 17:08:51 +0200
Subject: [PATCH] ARM: STi: DT: STiH41x: Convert all uppercase non-defines
 to lowercase
In-Reply-To: <20140625145354.GK13518@lee--X1>
References: <1401195188-23677-1-git-send-email-lee.jones@linaro.org>
 <20140625145354.GK13518@lee--X1>
Message-ID: <53AAE603.500@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/25/2014 04:53 PM, Lee Jones wrote:
>> Suggested-by: Olof Johansson <olof@lixom.net>
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>> ---
>>  arch/arm/boot/dts/stih415-pinctrl.dtsi   | 340 +++++++++++++++---------------
>>  arch/arm/boot/dts/stih416-b2020-revE.dts |   6 +-
>>  arch/arm/boot/dts/stih416-pinctrl.dtsi   | 342 +++++++++++++++----------------
>>  arch/arm/boot/dts/stih41x-b2000.dtsi     |   6 +-
>>  arch/arm/boot/dts/stih41x-b2020.dtsi     |   6 +-
>>  5 files changed, 350 insertions(+), 350 deletions(-)
> 
> What happened to this Maxime?
> 
> It was Acked by Olof, then died.  Did it slip through the net?
> 

You sent it to the ML after my last pull request for v3.16.
I think to take it for v3.17, but maybe you think it can go in next v3.16 rc?
If so, maybe Arnd or Olof can pick it directly, since we only have this single
patch for v3.16 fixes currently?

Anyway, you will have to rebase it I think, since stih416-b2020-revE.dts has
been renamed to stih416-b2020e.dts.

Don't hesitate to add my:
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Regards,
Maxime
