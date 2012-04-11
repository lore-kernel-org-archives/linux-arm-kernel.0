From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 11 Apr 2012 13:53:22 +0530
Subject: [GIT PULL] ARM: spear-soc DT support for 3.5
In-Reply-To: <CACRpkdbztwt_ztxy6__iuhH+5O+sy83xtpbROOr-0RZgkFwHPQ@mail.gmail.com>
References: <4F793C56.2030605@st.com>
 <CACRpkdbztwt_ztxy6__iuhH+5O+sy83xtpbROOr-0RZgkFwHPQ@mail.gmail.com>
Message-ID: <4F853F7A.1060605@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/11/2012 1:46 PM, Linus Walleij wrote:
>> > Viresh Kumar (8):
>> >      SPI/Pl022: Include types.h to remove compilation warnings
> This patch should go through Grant's SPI tree I think? Especially
> since it is eligible for -rc:s...

I knew about this issue and was almost sure, it wouldn't be
acceptable. :)

When i sent this pull request, this patch wasn't there in linux-next
and so i required it for basic compilation. Without it, compilation
was breaking.

I couldn't think of a way to handle it other than waiting for this
patch to come to linux-next.

-- 
viresh
