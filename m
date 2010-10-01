From: viresh.linux@gmail.com (viresh kumar)
Date: Fri, 1 Oct 2010 21:51:06 +0530
Subject: [PATCH V2 62/69] ST SPEAr: Appending spear3** with global
	structures
In-Reply-To: <f4787f6021bf3a8c009595749894332c05e656df.1285933332.git.viresh.kumar@st.com>
References: <cover.1285933331.git.viresh.kumar@st.com>
	<f4787f6021bf3a8c009595749894332c05e656df.1285933332.git.viresh.kumar@st.com>
Message-ID: <AANLkTi=xNoG2T1Q2JqB7TH+O7AjW++UnSt1Q85VgPbzp@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 1, 2010 at 5:26 PM, Viresh KUMAR <viresh.kumar@st.com> wrote:
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
> ?arch/arm/mach-spear3xx/include/mach/generic.h | ?140 ++++++++++++------------
> ?arch/arm/mach-spear3xx/spear300.c ? ? ? ? ? ? | ? 42 ++++----
> ?arch/arm/mach-spear3xx/spear300_evb.c ? ? ? ? | ? 43 ++++----
> ?arch/arm/mach-spear3xx/spear310.c ? ? ? ? ? ? | ? 16 ++--
> ?arch/arm/mach-spear3xx/spear310_evb.c ? ? ? ? | ? 37 ++++---
> ?arch/arm/mach-spear3xx/spear320.c ? ? ? ? ? ? | ? 32 +++---
> ?arch/arm/mach-spear3xx/spear320_evb.c ? ? ? ? | ? 50 +++++----
> ?arch/arm/mach-spear3xx/spear3xx.c ? ? ? ? ? ? | ? 20 ++--
> ?arch/arm/plat-spear/include/plat/spi.h ? ? ? ?| ? ?2 +-
> ?9 files changed, 193 insertions(+), 189 deletions(-)

Hello everybody,

I have used an latest patch on git for sending this patch series. I
think there is some bug
there, due to which all of you have received some mails which are not
intended for all of you.
There was a bugfix in git which enables to send mail to "recipients
mentioned in TO field", of patch
itself.

After creating patches (with git format-patch ---), i have added To
and CC lists in patches.
But when i sent patches the TO field was carried away in later patches
too. So due to this
all patches send after rtc patches have following recipients added:
rtc-linux at googlegroups.com,
a.zummo at towertech.it. Similarly for other patches too.

Once again sorry for this.

--
viresh
