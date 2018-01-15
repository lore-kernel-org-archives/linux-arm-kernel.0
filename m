From: patrice.chotard@st.com (Patrice CHOTARD)
Date: Mon, 15 Jan 2018 17:43:29 +0000
Subject: [PATCH 2/7] ARM: dts: STi: Add gpio polarity for "hdmi, hpd-gpio"
 property
In-Reply-To: <CAK8P3a3thPTMgcMRT0jqwoOidhxXndWCP0tYpUsPhMTW7DvgCA@mail.gmail.com>
References: <1515572469-19276-1-git-send-email-patrice.chotard@st.com>
 <1515572469-19276-3-git-send-email-patrice.chotard@st.com>
 <CAK8P3a3thPTMgcMRT0jqwoOidhxXndWCP0tYpUsPhMTW7DvgCA@mail.gmail.com>
Message-ID: <aa7fb6b7-8fde-8206-7459-e7fe14dc2f09@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd

On 01/15/2018 03:59 PM, Arnd Bergmann wrote:
> On Wed, Jan 10, 2018 at 9:21 AM,  <patrice.chotard@st.com> wrote:
>> From: Patrice Chotard <patrice.chotard@st.com>
>>
>> The GPIO polarity is missing in the hdmi,hpd-gpio property, this
>> fixes the following DT warnings:
>>
>> arch/arm/boot/dts/stih410-b2120.dtb: Warning (gpios_property): hdmi,hpd-gpio property
>> size (8) too small for cell size 2 in /soc/sti-display-subsystem/sti-hdmi at 8d04000
>>
>> arch/arm/boot/dts/stih407-b2120.dtb: Warning (gpios_property): hdmi,hpd-gpio property
>> size (8) too small for cell size 2 in /soc/sti-display-subsystem/sti-hdmi at 8d04000
>>
>> arch/arm/boot/dts/stih410-b2260.dtb: Warning (gpios_property): hdmi,hpd-gpio property
>> size (8) too small for cell size 2 in /soc/sti-display-subsystem/sti-hdmi at 8d04000
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> 
> Olof has picked up a number of other dtc warning fixes into next/dt,
> so I ended up
> adding this to the same place rather than our fixes branch, but added
> a Cc:stable
> tag. We now have just one warning left in arm-soc, and I think Linus
> Walleij will
> send a patch for that soon. >
> Please send a pull request for the remaining commits from the STi
> series, thanks!

Ok thanks

Patrice

> 
>        Arnd
> 
