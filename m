From: patrice.chotard@st.com (Patrice CHOTARD)
Date: Thu, 11 Jan 2018 07:50:14 +0000
Subject: [PATCH 0/7] ARM: dts: STi: Fix DT dtc warnings
In-Reply-To: <CAK8P3a0MTfmNZNnXQcgDWo8dhGAQkkKVdTJhjRvpRi_0L_wXTA@mail.gmail.com>
References: <1515572469-19276-1-git-send-email-patrice.chotard@st.com>
 <CAK8P3a2qgyJ8Hgr6fLnn6jVRhHVtcc1kxzyD2N7Bb7gzPe1xfg@mail.gmail.com>
 <20f04806-2f33-3c16-d790-4a93c4c7187a@st.com>
 <CAK8P3a0MTfmNZNnXQcgDWo8dhGAQkkKVdTJhjRvpRi_0L_wXTA@mail.gmail.com>
Message-ID: <c1a0ab43-a4fa-4de3-b2ad-02485d43db66@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Arnd

On 01/10/2018 09:52 PM, Arnd Bergmann wrote:
> On Wed, Jan 10, 2018 at 6:17 PM, Patrice CHOTARD <patrice.chotard@st.com> wrote:
>> Hi Arnd
>>
>> On 01/10/2018 04:52 PM, Arnd Bergmann wrote:
>>> On Wed, Jan 10, 2018 at 9:21 AM,  <patrice.chotard@st.com> wrote:
>>>> From: Patrice Chotard <patrice.chotard@st.com>
>>>>
>>>> This series fixes all dtc warnings related to STi platforms dt files.
>>>> It has been triggered by Rob Herring [1]
>>>>
>>>> [1] https://www.spinics.net/lists/devicetree/msg206209.html
>>>>
>>>> For most of implicated node, a simple move outside the soc node
>>>> solves the warnings.
>>>>
>>>> Patrice Chotard (7):
>>>>     ARM: dts: STi: fix bindings notation
>>>>     ARM: dts: STi: Add gpio polarity for "hdmi,hpd-gpio" property
>>>>     ARM: dts: STi: Move clocks without reg outside soc
>>>>     ARM: dts: STi: Move leds node outside soc node
>>>>     ARM: dts: STi: Move usb2_picophyX nodes without reg out of soc
>>>>     ARM: dts: STi: Move sound related nodes without reg out of soc
>>>>     ARM: dts: STi: Add fake reg property for sti-display-subsystem
>>>
>>> Thanks a lot for addressing these!
>>>
>>> As far as I can tell, there is one patch in particular that addresses a warning
>>> we get at the default warning level: "ARM: dts: STi: Add gpio polarity for
>>> "hdmi,hpd-gpio" property". Should we merge that one for 4.15 to get closer
>>> to a clean build again? I'm not sure whether we can address the other
>>
>> How do you want to proceed with this particular patch ?
>> Do you want me to send a pull-request with this patch ?
>>
>> Patrice
> 
> I'd just pick it up directly into the arm-soc fixes branch if that
> works for you.

Perfect ;-)

Thanks

Patrice

> 
>         Arnd
> 
