From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 30 Mar 2012 07:04:55 +0200
Subject: [RFC] pinctrl: Replace list_groups() with get_groups_count()
In-Reply-To: <4F753007.2030707@st.com>
References: <CAOh2x==LTHPM+O9LXVFVdX2NfzKs2bttiYLm8VcL6qLXKrUMBg@mail.gmail.com>
 <4F749B58.4070608@wwwdotorg.org>
 <CAOh2x==mGDZRoxdbuvbhKtfoxiEDVb+7vdfBEYD=u+DdMCYVhw@mail.gmail.com>
 <4F74A05E.7050803@wwwdotorg.org> <4F753007.2030707@st.com>
Message-ID: <CACRpkdYaJ8sH0u6VTiaiPOJJ-D0pDo5oONyFXA4EvtL+WXEtjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 6:01 AM, Viresh Kumar <viresh.kumar@st.com> wrote:

> Anyway, if others implement it, that doesn't mean we also do that, even
> if we are not happy with it. It is not only about cleaning of code, but
> it will save boot time too.
>
> @Linus: Can i have your viewpoint before i start doing this?

Just patch it, as detailed in the other letter there is really no point
for having it like this so go ahead. As long as you also patch all
the users and remove the old interface, just rewrite it. If you could
also test it on something it'd be nice ...

Yours,
Linus Walleij
