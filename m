From: amelie.delaunay@st.com (Amelie DELAUNAY)
Date: Thu, 22 Feb 2018 15:33:31 +0000
Subject: [PATCH 3/6] gpio: Add GPIO support for the ST Multi-Function
 eXpander
In-Reply-To: <CACRpkdaeFXuB1Qv-vqNpf4pHsAysiYh03_gfNoRdHBh1pN_Amw@mail.gmail.com>
References: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com>
 <1518100057-23234-4-git-send-email-amelie.delaunay@st.com>
 <CACRpkdaeFXuB1Qv-vqNpf4pHsAysiYh03_gfNoRdHBh1pN_Amw@mail.gmail.com>
Message-ID: <2440a092-507d-bc39-6ed6-4a4ee094da7a@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/22/2018 02:47 PM, Linus Walleij wrote:
> On Thu, Feb 8, 2018 at 3:27 PM, Amelie Delaunay <amelie.delaunay@st.com> wrote:
> 
>> ST Multi-Function eXpander (MFX) can be used as GPIO expander.
>> It has 16 fast GPIOs and can have 8 extra alternate GPIOs
>> when other MFX features are not enabled.
>>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> 
> As mentioned I think this driver needs to:
> 
> - Move to drivers/pinctrl/pinctrl-stmfx.c similar to the sx150x controller.
> - Pass a regmap around instead of the custom accessor functions.

I study this right now!
Thanks,
Amelie

> - Maybe refactor and reuse STMPE infrastructure
> 
> Yours,
> Linus Walleij
> 
