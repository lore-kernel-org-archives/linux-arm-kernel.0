From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 22 Mar 2012 09:00:44 +0100
Subject: [PATCH] serial: PL011: move interrupt clearing
In-Reply-To: <CAOh2x==5QHEcA3h216p8rJukx0LR=cVcGYN84aqzw=fnhu8Y-g@mail.gmail.com>
References: <1332357318-8017-1-git-send-email-linus.walleij@linaro.org>
 <CAOh2x==5QHEcA3h216p8rJukx0LR=cVcGYN84aqzw=fnhu8Y-g@mail.gmail.com>
Message-ID: <CACRpkdate+sQJvS8H7qNXiwe6c+F58g=OF0Qg=TxxnTwPXBrYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 22, 2012 at 2:04 AM, viresh kumar <viresh.linux@gmail.com> wrote:

>> Cc: Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: stable <stable@vger.kernel.org>
>> Reported-by: Viresh Kumar <viresh.kumar@st.com>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> ?drivers/tty/serial/amba-pl011.c | ? ?8 ++++----
>> ?1 files changed, 4 insertions(+), 4 deletions(-)
>
> You missed me in CC??

I put you in Reported-by, then used --cc at the prompt because git send-email
still does not realize it must put Reported-by: tags on the CC list.

Yours,
Linus Walleij
