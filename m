From: maxime.coquelin@st.com (Maxime COQUELIN)
Date: Thu, 10 Oct 2013 15:33:43 +0200
Subject: [PATCH v4 0/4] Add I2C support to ST SoCs
In-Reply-To: <20131010100354.GE2638@katana>
References: <1381250576-7916-1-git-send-email-maxime.coquelin@st.com>
 <525675B6.4080404@st.com> <20131010100354.GE2638@katana>
Message-ID: <5256ACB7.7050302@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 10/10/2013 12:03 PM, Wolfram Sang wrote:
>>> Changes since v3:
>>>     - Switch back to vendor specific DT properties regarding the anti-glitch
>>>       filter configuration, as this IP is the only one having such a filter.
>> Do you agree to keep these properties vendor-specifics?
> My preference is generic bindings. There are no other users right now,
> yet there might be in the future. At least with something similar enough
> that the bindings will apply. Was hoping for some additional input,
> though, but I am not depending on it.
I have to push another revision to change the IRQ flags as reported by 
Stephen G.
I will also revert to generic bindings in this revision.
For their documentation, I will add it as soon as you will have created 
the DT binding documentation of I2C.

Is it okay for you?
>
>> If so, could you take this series for v3.13?
> Sure, if it passes the second review...
For sure!

Regards,
Maxime
