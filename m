From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 18 May 2012 12:13:54 +0530
Subject: [PATCH] gpiolib: Add of_get_gpio_chip_by_phandle() helper
In-Reply-To: <CACxGe6s=TNuYd+L-5DyvUZZbZ-h4qXOouxWfSg8Wr2+kG5tLOw@mail.gmail.com>
References: <cdf5352edf6b32e2505e1c7ba9997613150094c1.1335949228.git.viresh.kumar@st.com>
 <4FA15267.4090306@wwwdotorg.org>
 <CAOh2x=nrNDrtNjOroWOm6HkYkc3f2qfaWrtN97d1M3rWv1qmsQ@mail.gmail.com>
 <CACRpkda2jBmjPCgt=5rfqdCQH9Lipq4aejeQq-Qbw0_Nk6o-yg@mail.gmail.com>
 <CAOh2x=nizQYXWFu3deQPXr93Nqv77Pnj5DNhYZw_vYyY2go3vA@mail.gmail.com>
 <CACRpkdZGAQpt1bqhTFmxcC7OKb4uds6ru-aNs-aT+M+H4TKuJg@mail.gmail.com>
 <20120518000800.B9F333E062C@localhost> <4FB5C56E.8070705@st.com>
 <CACxGe6s=TNuYd+L-5DyvUZZbZ-h4qXOouxWfSg8Wr2+kG5tLOw@mail.gmail.com>
Message-ID: <4FB5EFAA.1060900@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/18/2012 11:16 AM, Grant Likely wrote:
> Ugh; that seems a little messy.  With dynamic allocation of gpio
> numbers, there is no guarantee that all the gpio_chips will have
> contiguous gpio_bases.  It would require internal knowledge of each
> gpio controller's binding.  How do you intend to use that API?

I need gpio_chip base in my pinctrl driver to convert from gpio number
to pin number. That's it. Please suggest how should i fix this up. :)

-- 
viresh
