From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 11 Nov 2014 16:16:44 +0530
Subject: [PATCH v5 2/8] phy: miphy28lp: Add PHY header file for DT x Driver
 defines
In-Reply-To: <546095EC.2040501@st.com>
References: <1415098284-11182-1-git-send-email-gabriel.fernandez@linaro.org>
 <1415098284-11182-3-git-send-email-gabriel.fernandez@linaro.org>
 <545B1C53.9010406@ti.com> <545B3FA4.8040109@st.com>
 <20141106112825.GC26543@x1> <545B6144.2020503@st.com>
 <20141106153659.GD26543@x1> <545B9F15.5070404@st.com>
 <20141107130538.GB3745@x1> <546095EC.2040501@st.com>
Message-ID: <5461E914.30906@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday 10 November 2014 04:09 PM, Maxime Coquelin wrote:
> 
> On 11/07/2014 02:05 PM, Lee Jones wrote:
> 
> <snip>
>> If the merge turns out to be simple, then Git will do the correct
>> thing; however, if the first version of the patch is applied, then
>> some changes around the same area of the file occur _then_ when the
>> second version (of the same patch differing only by SHA1) is applied
>> Git will get confused.  If it has the same SHA1 however, Git will
>> discard it as 'already applied'.  This is the reason we pass around
>> shared tags to immutable branches.
> Looking at how the patch is trivial, I persist to think there is no issue.
> But OK, I will prepare an immutable branch..

I've pushed this to
git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git
tags/phy-dt-header

I generally use 'git rebase' since that doesn't create a separate merge commit,
but it's up to you,

Thanks
Kishon
