From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Wed, 1 Feb 2017 17:47:43 +0100
Subject: [PATCH 0/8] ADD STM32H743 MCU and STM32H743i-Eval board supports
In-Reply-To: <CACRpkdb35JdbE5bPMU_NeVehnA-qs3aAxCgE0==L=Z9vmq1yWQ@mail.gmail.com>
References: <1485868465-30446-1-git-send-email-alexandre.torgue@st.com>
 <CACRpkdb35JdbE5bPMU_NeVehnA-qs3aAxCgE0==L=Z9vmq1yWQ@mail.gmail.com>
Message-ID: <83444163-8b25-b2e9-205a-188f29df0d24@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus

On 02/01/2017 04:16 PM, Linus Walleij wrote:
> On Tue, Jan 31, 2017 at 2:14 PM, Alexandre TORGUE
> <alexandre.torgue@st.com> wrote:
>
>> This series adds basic support for STM32H743 MCU and stm32h743i-eval board.
>> With it, you can boot stm32h743i-eval board successfully.
>
> Patch 1 & 2 look fine to me.
>
> Shall I just apply them and offer them on an immutable branch based
> on v4.10 so you can pull that into ARM SoC if you want to get this in
> for v4.11?

Thanks, but I think it is a bit late for this cycle. Indeed I'm close to 
send a second round for STM32 DT, but I don't plan to add STM32H7 
support. I prefere to let machine & DT patches in review.
Anyway, I 'll be happy if you take pinctrl & bindings parts in this 
cycle :).

Regards
Alex

>
> Yours,
> Linus Walleij
>
