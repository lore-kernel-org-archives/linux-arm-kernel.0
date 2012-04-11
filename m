From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 11 Apr 2012 10:17:38 +0200
Subject: [GIT PULL] ARM: spear-soc DT support for 3.5
In-Reply-To: <4F83FAE2.8020107@st.com>
References: <4F793C56.2030605@st.com>
 <CAOh2x=n8GO-vzFgDEdeyUVdGiOE_-BxgpC5+LbKRMtvgnoSxHQ@mail.gmail.com>
 <CACRpkdZgfY340a5=Mgs0WwTO1e4AiKxv3-xm4pbpEg2jOmiNgg@mail.gmail.com>
 <4F83FAE2.8020107@st.com>
Message-ID: <CACRpkdbaG0uKeCrAsc8Q4sfY0yY=h48esY=z=Wb8HWHBLK6aVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2012 at 11:18 AM, Viresh Kumar <viresh.kumar@st.com> wrote:
> On 4/10/2012 2:12 PM, Linus Walleij wrote:
>> Will there be conflicts between this patch set and the stuff you're
>> submitting for pinctrl? Or is it just runtime problems?
>
> Yes. There will be conflicts. I have touched dts files in pinctrl patches
> that got added in this patchset.

Hm, then we should maybe consider mergeing all that pinctrl stuff
through ARM SoC later as well. I can probably provide the
necessary ACKs.

Yours,
Linus Walleij
