From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 22 Nov 2012 08:49:22 +0530
Subject: [PATCH 00/14] ARM: SPEAr: DT updates
In-Reply-To: <20121121202405.GA15549@quad.lixom.net>
References: <cover.1352608333.git.viresh.kumar@linaro.org>
 <201211121521.58766.arnd@arndb.de>
 <CAKohpom0kMjuHx5jO-LTPKQhy_-r4khKi7UBPB_O-50K42FOeQ@mail.gmail.com>
 <20121121202405.GA15549@quad.lixom.net>
Message-ID: <CAKohpokMUTQja6tCz1RmKXFgu+X7MGFAi1+UWLgKhpViOuiMSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 November 2012 01:54, Olof Johansson <olof@lixom.net> wrote:
> for-next is LinusW's unstable branch. If the patches have moved over into
> his /devel branch we can normally pull them in as a dependency though. Do
> you happen to know which patches we need for this in particular, i.e. at
> what point we need to pull in the branch? I don't want to have to search
> for it if I can avoid and we try to pull in minimal dependencies if
> we can, instead of all his staged code.
>
> We're also running out of time for 3.8 staging, but if you're able to
> figure out the above I'll make an attempt to apply the patches from above.

Hi Olof,

Last week i had chat with Arnd and Linus over Hangout, and following is
the status:
- Dependency patch of pinctrl is:

commit 4ddb1c295752252f61670e35c791bf16e58bbce6
Author: Viresh Kumar <viresh.kumar@linaro.org>
Date:   Sat Oct 27 15:21:39 2012 +0530

    ARM: SPEAr: Add plgpio node in device tree dtsi files

And is already in pinctrl/devel branch. And this branch is stable as per Linus.

- First patch of this set is applied by Linus in his gpio tree. So,
you need to get
that branch too. And is present in devel branch as:

commit b53bc2819a71099ecfc3d61ba0796b3dcc6be321
Author: Shiraz Hashim <shiraz.hashim@st.com>
Date:   Fri Nov 16 10:45:25 2012 +0530

    gpio: SPEAr: add spi chipselect control driver

--
viresh
