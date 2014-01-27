From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 Jan 2014 10:43:37 +0100
Subject: [PATCH v2 2/4] pinctrl: st: Add software edge trigger interrupt
 support.
In-Reply-To: <20140124082859.GJ8586@lee--X1>
References: <1389886545-31498-1-git-send-email-srinivas.kandagatla@st.com>
 <1389886651-31990-1-git-send-email-srinivas.kandagatla@st.com>
 <CACRpkdaBAnpfHBqkgU2emZrYwHGh9KvDvqfnCvaWdU5jYgxStA@mail.gmail.com>
 <20140124082859.GJ8586@lee--X1>
Message-ID: <CACRpkdb9cM_dh7UNpErv+gKrvMW0HbE7NcZq22AiZfEjrqS1qA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 24, 2014 at 9:28 AM, Lee Jones <lee.jones@linaro.org> wrote:
>> > +/*
>> > + * As edge triggers are not supported at hardware level, it is supported by
>> > + * software by exploiting the level trigger support in hardware.
>>
>> (...)
>>
>> All this is quite hard to understand. Maybe it's just because
>> it's hard overall. Edge triggers are not supported by hardware
>> so we use the hardware edge trigger support?
>>
>> That is a bit oxymoronic...
>
> That's not what is says. Read it again. :)

Argh yeah I was wrong ... it's perfectly consistent with the
implementation. Sorry for being such a slow brain this last
friday.

Yours,
Linus Walleij
