From: viresh.kumar@st.com (viresh kumar)
Date: Fri, 3 Sep 2010 09:28:15 +0530
Subject: [PATCH 31/74] ST SPEAr: Adding support for SSP PL022
In-Reply-To: <AANLkTi=Fiv2i4qMcrnOeECkMKtNathO9P906=T1gcFPB@mail.gmail.com>
References: <cover.1283161023.git.viresh.kumar@st.com>	<447e0086df5d9eac78a2fc4ccf7ad51ecbed0232.1283161023.git.viresh.kumar@st.com>
	<AANLkTi=Fiv2i4qMcrnOeECkMKtNathO9P906=T1gcFPB@mail.gmail.com>
Message-ID: <4C807257.4030305@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/3/2010 12:48 AM, Linus Walleij wrote:
>> > +               .modalias = "spidev",
>> > +               .controller_data = &spi0_dev_chip_info,
>> > +               .max_speed_hz = 10000000,
>> > +               .bus_num = 0,
>> > +               .chip_select = 0,
>> > +               .mode = 0,
>> > +       }, {
>> > +#endif
> Please grep your code for all #if 0 and remove it.

Sorry for the noise!!! Will correct it.
