From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Tue, 9 Mar 2010 21:14:53 +0100
Subject: [PATCH 01/11] ST SPEAr: Added ARM PrimeXsys System Controller
	SP810 header file
In-Reply-To: <1267592861-26911-2-git-send-email-viresh.kumar@st.com>
References: <1267592861-26911-1-git-send-email-viresh.kumar@st.com>
	<1267592861-26911-2-git-send-email-viresh.kumar@st.com>
Message-ID: <63386a3d1003091214s5251674et99903756f3528e66@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/3/3 Viresh KUMAR <viresh.kumar@st.com>:

> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
> ?include/linux/sysctl_sp810.h | ? 59 ++++++++++++++++++++++++++++++++++++++++++
> ?1 files changed, 59 insertions(+), 0 deletions(-)
> ?create mode 100644 include/linux/sysctl_sp810.h
> (...)

To the rest of the world this is probably a number of register definitions and
an obscure inline function, so the entire internal kernel API does not need
to know about it.

Move it to arch/arm/include/asm/hardware

Yours,
Linus Walleij
