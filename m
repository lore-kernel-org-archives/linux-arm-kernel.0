From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 May 2012 14:39:23 +0200
Subject: [RFC 0/5] pinctrl: SPEAr Updates
In-Reply-To: <cover.1335526926.git.viresh.kumar@st.com>
References: <cover.1335526926.git.viresh.kumar@st.com>
Message-ID: <CACRpkdaDjqE91aZ2HHx0Zy1D9Ad7sVAC7w0cMc_8FOZd2+uVNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 1:43 PM, Viresh Kumar <viresh.kumar@st.com> wrote:

> This patchset mainly focuses on providing support to configure SPEAr pads as
> gpios. For this i have added a gpiolib based driver and few changes in other
> SPEAr pinctrl drivers.
>
> It also contains minor fixes.
>
> I haven't tested it till now, only compile tested.
> I wanted to get a first level of review, so posting this set.
>
> One thing currently broken is: Passing gpio base via DT.

Overall this looks good, just want you to use macros as commented
in one patch.

Yours,
Linus Walleij
