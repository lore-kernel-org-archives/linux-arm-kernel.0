From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 12 Sep 2016 15:38:32 +0200
Subject: [PATCH v4 6/9] pinctrl: Add IRQ support to STM32 gpios
In-Reply-To: <CACRpkdYYoMqCqq=L53LFUxCM=q00q5YhcxB=+-ZhxkAUbJEB5Q@mail.gmail.com>
References: <1473180341-1999-1-git-send-email-alexandre.torgue@st.com>
 <1473180341-1999-7-git-send-email-alexandre.torgue@st.com>
 <CACRpkdZ_r0phJeScTYs_LmEHavcjGo6YjHPEHo-rKAv+rLgiFg@mail.gmail.com>
 <0063a1ef-1b09-7cfc-f18b-76f2bb07eb84@st.com>
 <CACRpkdYYoMqCqq=L53LFUxCM=q00q5YhcxB=+-ZhxkAUbJEB5Q@mail.gmail.com>
Message-ID: <77a03549-232b-f73e-216f-6e332192cb1c@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 09/12/2016 02:58 PM, Linus Walleij wrote:
> On Thu, Sep 8, 2016 at 5:47 PM, Alexandre Torgue
> <alexandre.torgue@st.com> wrote:
>
>> Just one question, when you say "super-complex irqchip in use", do you mean
>> I could use another (simplest) solution to handle this EXTI controller?
>
> I don't know, GPIOLIB_IRQCHIP is to be used for some specific
> cases documented in Documentation/gpio/driver.txt.
>
> For anything complex, we either need to have this hairy code
> or invent new abstractions.
>
Ok I see
.
> For now, I assume this is needed...

Yes it is.

Regards
Alex

>
> Yours,
> Linus Walleij
>
