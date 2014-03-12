From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Wed, 12 Mar 2014 16:26:26 +0100
Subject: [PATCH v4 0/6] Add STiH407 SoC and reference board support
In-Reply-To: <CACRpkdboBkzcJC35-BNvVYmS_t9Cd204AVz4rZasKtNJp0yE4g@mail.gmail.com>
References: <1394614210-15698-1-git-send-email-maxime.coquelin@st.com>
 <CACRpkdboBkzcJC35-BNvVYmS_t9Cd204AVz4rZasKtNJp0yE4g@mail.gmail.com>
Message-ID: <53207CA2.4090309@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 03/12/2014 03:20 PM, Linus Walleij wrote:
> On Wed, Mar 12, 2014 at 9:50 AM, Maxime COQUELIN <maxime.coquelin@st.com> wrote:
>
>> This series adds basic support to the STMicroelectronics STiH407 SoC and its
>> B2120 reference board. The STiH407 is a dual-core ARM Cortex-A9 CPU aimed at
>> STB market.
>>
>> Changes since v3:
>
> I've applied the pinctrl changes to the pinctrl tree, please push all the
> DTS[i] changes through ARM SoC.
As mentioned in the cover-letter, the DTS changes are based on arm_soc's 
for-next branch.

Do you mean I should send a pull request for these three patches?


>
> There is no need to keep DTS and subsystem changes in sync as
> the DTS'es are supposed to be maintained in separation in the
> future anyway.
>

Understood.

Thanks,
Maxime
> Yours,
> Linus Walleij
>
