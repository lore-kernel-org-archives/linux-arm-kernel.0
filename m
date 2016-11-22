From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 22 Nov 2016 17:18:20 +0000
Subject: [PATCH 5/7] add bindings for stm32 IIO timer drivers
In-Reply-To: <CA+M3ks6ZoOND4VobU65OntEYU-f_XoNCV4wNZZ0_dYoOxy73+w@mail.gmail.com>
References: <1479831207-32699-1-git-send-email-benjamin.gaignard@st.com>
 <1479831207-32699-6-git-send-email-benjamin.gaignard@st.com>
 <b9a82ce7-745a-1c25-f97f-68aaf0551f3b@metafoo.de>
 <CA+M3ks6ZoOND4VobU65OntEYU-f_XoNCV4wNZZ0_dYoOxy73+w@mail.gmail.com>
Message-ID: <20161122171820.GL10134@dell.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Nov 2016, Benjamin Gaignard wrote:

> [snip]
> >> +     "st,stm32-iio-timer5"
> >> +     "st,stm32-iio-timer6"
> >> +     "st,stm32-iio-timer7"
> >> +     "st,stm32-iio-timer8"
> >> +     "st,stm32-iio-timer9"
> >> +     "st,stm32-iio-timer10"
> >> +     "st,stm32-iio-timer11"
> >> +     "st,stm32-iio-timer12"
> >> +     "st,stm32-iio-timer13"
> >> +     "st,stm32-iio-timer14"
> >
> > We can't do this. This is a binding for a driver, not for the hardware.
> >
> 
> Unfortunately each instance for the hardware IP have little
> differences like which triggers they could accept or size of the
> counter register,
> and I doesn't have value inside the hardware to distinguish them so
> the only way I found is to use compatible.

Can't you represent these as properties?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
