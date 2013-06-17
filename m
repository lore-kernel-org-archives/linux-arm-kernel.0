From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Jun 2013 18:27:28 +0200
Subject: [PATCH v2 05/11] pinctrl:stixxxx: Add pinctrl and pinconf support.
In-Reply-To: <51BF0FC2.4000601@st.com>
References: <1370855828-5318-1-git-send-email-srinivas.kandagatla@st.com>
 <1370856161-6600-1-git-send-email-srinivas.kandagatla@st.com>
 <CACRpkdYN-6W8tvbWNVOdCKOWObm3PCtzXqZuUnvHddBtyw2pyQ@mail.gmail.com>
 <51BF0FC2.4000601@st.com>
Message-ID: <CACRpkdbJD=bgLizJkDV2eVNs-eOQ0LLo+PtqmhKCN47eH7=fkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 3:31 PM, Srinivas KANDAGATLA
<srinivas.kandagatla@st.com> wrote:

>>> +config PINCTRL_STIXXXX
>>
>> As mentioned elsewhere STIXXXX is a bit too much X:es in.
>> Please come up with some better naming if possible.
>
> Are you OK if I use pinctrl-st.c?

It seems to no be taken so OK :-)

The best choice is just the name of the IP block,
something unique. I would consider trying to ask the
hardware engineer writing that pinctrl block what name
s/he prefer on it, if not possible just go with pinctrl-st.c.

The rest seems to be addressed nicely, waiting for the
next iteration!

Yours,
Linus Walleij
