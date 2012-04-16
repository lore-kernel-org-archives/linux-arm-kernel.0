From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 16 Apr 2012 14:50:47 +0200
Subject: Pinctrl crash on latest linux-next/master
In-Reply-To: <4F8BFA3F.5030409@st.com>
References: <4F8BFA3F.5030409@st.com>
Message-ID: <CACRpkdb9JOKK=XY0t3GcrOCxyfefi5nw08S4yv=bXREemOM10w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2012 at 12:53 PM, Viresh Kumar <viresh.kumar@st.com> wrote:

> I don't know if the issue is in my patches or something else, but i was
> able to boot it earlier. Till my V3 for pinctrl. And nothing much changed
> since then, i just rebased on latest kernel.

Hm I haven't tested the pinctrl tree on v3.4-rc3 yet.

Did you git bisect to figure out which patch broke it?

Yours,
Linus Walleij
