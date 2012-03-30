From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 30 Mar 2012 07:14:34 +0200
Subject: [RFC] pinctrl: Replace list_groups() with get_groups_count()
In-Reply-To: <4F753FF3.4040704@st.com>
References: <CAOh2x==LTHPM+O9LXVFVdX2NfzKs2bttiYLm8VcL6qLXKrUMBg@mail.gmail.com>
 <4F749B58.4070608@wwwdotorg.org>
 <CAOh2x==mGDZRoxdbuvbhKtfoxiEDVb+7vdfBEYD=u+DdMCYVhw@mail.gmail.com>
 <4F74A05E.7050803@wwwdotorg.org> <4F753007.2030707@st.com>
 <CACRpkdYaJ8sH0u6VTiaiPOJJ-D0pDo5oONyFXA4EvtL+WXEtjw@mail.gmail.com>
 <4F753FF3.4040704@st.com>
Message-ID: <CACRpkdaJpy_iRg4XzJepn=5tXLxBeYq3aMk1M_Z7WLD1+gw8iA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 7:09 AM, Viresh Kumar <viresh.kumar@st.com> wrote:

> BTW, i am planning not to add another call, get_groups_count(),
> but add another field like ngroups, which would be set by users.

get_groups_count() may make some sense if the number of
available groups could in some instance change at runtime.
Maybe a bit overcautious and pedantic but you never know...

But do it any way you like, I don't worry very much :-)

Yours,
Linus Walleij
