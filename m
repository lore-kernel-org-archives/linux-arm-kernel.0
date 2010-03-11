From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 11 Mar 2010 12:26:08 +0100
Subject: [PATCH 04/11] ST SPEAr: Added basic header files for SPEAr
	platform
In-Reply-To: <4B98BC40.1030306@st.com>
References: <1267592861-26911-1-git-send-email-viresh.kumar@st.com>
	<1267592861-26911-3-git-send-email-viresh.kumar@st.com>
	<1267592861-26911-4-git-send-email-viresh.kumar@st.com>
	<1267592861-26911-5-git-send-email-viresh.kumar@st.com>
	<63386a3d1003092140o67a6c943rdee3a6c905cea7ef@mail.gmail.com>
	<4B973CF6.4030009@st.com>
	<63386a3d1003100131v7027e44cu5031c9ee3bf6ec73@mail.gmail.com>
	<4B977067.3050108@st.com>
	<63386a3d1003102243w637a8ce1m838a2dba946add32@mail.gmail.com>
	<4B98BC40.1030306@st.com>
Message-ID: <63386a3d1003110326h44ac3fb7q88aa557fc010a763@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/3/11 Shiraz HASHIM <shiraz.hashim@st.com>:

> Can we use clockevents directly? I though they are abstracted by the kernel
> framework and using them directly is not advisable/feasible.

Not that I know, but as tglx says it might soon be possible to do so, and if
you have a patch for using some surplus clockevents for this along with some
example of it actually being used too, people will probably react,
atleast they will have opinions.

Yours,
Linus Walleij
