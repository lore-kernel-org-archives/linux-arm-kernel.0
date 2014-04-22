From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Tue, 22 Apr 2014 14:17:00 +0200
Subject: [PATCH v4 0/6] Add STiH407 SoC and reference board support
In-Reply-To: <CACRpkdZ7NpQBnpKLWSMST6fW9ST_tHi6L66jTQ4kh=+ONfjMgg@mail.gmail.com>
References: <1394614210-15698-1-git-send-email-maxime.coquelin@st.com>	<CACRpkdboBkzcJC35-BNvVYmS_t9Cd204AVz4rZasKtNJp0yE4g@mail.gmail.com>	<53207CA2.4090309@st.com>
 <CACRpkdZ7NpQBnpKLWSMST6fW9ST_tHi6L66jTQ4kh=+ONfjMgg@mail.gmail.com>
Message-ID: <53565DBC.6040709@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

On 03/14/2014 11:14 AM, Linus Walleij wrote:
> On Wed, Mar 12, 2014 at 4:26 PM, Maxime Coquelin <maxime.coquelin@st.com> wrote:
>> On 03/12/2014 03:20 PM, Linus Walleij wrote:
>
>>> I've applied the pinctrl changes to the pinctrl tree, please push all the
>>> DTS[i] changes through ARM SoC.
>>
>> As mentioned in the cover-letter, the DTS changes are based on arm_soc's
>> for-next branch.
>>
>> Do you mean I should send a pull request for these three patches?
>
> You'd have to ask the ARM SoC maintainers, but if it's a few patches
> they can also apply them directly on the target branch.

It looks like the get_maintainer.pl script does not give your names.
Are DT and mach-sti patches good for you?

If so, can I have you Ack?

Thanks,
Maxime

>
> Yours,
> Linus Walleij
>
