From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Mon, 10 Nov 2014 11:39:40 +0100
Subject: [PATCH v5 2/8] phy: miphy28lp: Add PHY header file for DT x Driver
 defines
In-Reply-To: <20141107130538.GB3745@x1>
References: <1415098284-11182-1-git-send-email-gabriel.fernandez@linaro.org>
 <1415098284-11182-3-git-send-email-gabriel.fernandez@linaro.org>
 <545B1C53.9010406@ti.com> <545B3FA4.8040109@st.com>
 <20141106112825.GC26543@x1> <545B6144.2020503@st.com>
 <20141106153659.GD26543@x1> <545B9F15.5070404@st.com>
 <20141107130538.GB3745@x1>
Message-ID: <546095EC.2040501@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 11/07/2014 02:05 PM, Lee Jones wrote:

<snip>
> If the merge turns out to be simple, then Git will do the correct
> thing; however, if the first version of the patch is applied, then
> some changes around the same area of the file occur _then_ when the
> second version (of the same patch differing only by SHA1) is applied
> Git will get confused.  If it has the same SHA1 however, Git will
> discard it as 'already applied'.  This is the reason we pass around
> shared tags to immutable branches.
Looking at how the patch is trivial, I persist to think there is no issue.
But OK, I will prepare an immutable branch..

Kishon, checkpatch complains because this new file has no maintainer.
Is it ok for you if I add it to the Generic PHY subsystem?

Regards,
Maxime
