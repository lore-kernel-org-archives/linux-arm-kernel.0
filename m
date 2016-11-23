From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Wed, 23 Nov 2016 09:17:58 +0100
Subject: [PATCH 5/7] add bindings for stm32 IIO timer drivers
In-Reply-To: <20161122171820.GL10134@dell.home>
References: <1479831207-32699-1-git-send-email-benjamin.gaignard@st.com>
 <1479831207-32699-6-git-send-email-benjamin.gaignard@st.com>
 <b9a82ce7-745a-1c25-f97f-68aaf0551f3b@metafoo.de>
 <CA+M3ks6ZoOND4VobU65OntEYU-f_XoNCV4wNZZ0_dYoOxy73+w@mail.gmail.com>
 <20161122171820.GL10134@dell.home>
Message-ID: <CA+M3ks7MgnUJoDoNG157+MbdhgbqwzRmhPcD-uQKC7_DJVAK6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If it is ok for you I will add "id" parameter in mfd driver and
forward it to the sub-devices drivers
to be able to distinguish the hardware blocks


2016-11-22 18:18 GMT+01:00 Lee Jones <lee.jones@linaro.org>:
> On Tue, 22 Nov 2016, Benjamin Gaignard wrote:
>
>> [snip]
>> >> +     "st,stm32-iio-timer5"
>> >> +     "st,stm32-iio-timer6"
>> >> +     "st,stm32-iio-timer7"
>> >> +     "st,stm32-iio-timer8"
>> >> +     "st,stm32-iio-timer9"
>> >> +     "st,stm32-iio-timer10"
>> >> +     "st,stm32-iio-timer11"
>> >> +     "st,stm32-iio-timer12"
>> >> +     "st,stm32-iio-timer13"
>> >> +     "st,stm32-iio-timer14"
>> >
>> > We can't do this. This is a binding for a driver, not for the hardware.
>> >
>>
>> Unfortunately each instance for the hardware IP have little
>> differences like which triggers they could accept or size of the
>> counter register,
>> and I doesn't have value inside the hardware to distinguish them so
>> the only way I found is to use compatible.
>
> Can't you represent these as properties?
>
> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org ? Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog



-- 
Benjamin Gaignard

Graphic Study Group

Linaro.org ? Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
