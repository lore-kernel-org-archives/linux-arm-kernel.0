From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 11 Apr 2012 14:17:00 +0530
Subject: [GIT PULL] ARM: spear-soc DT support for 3.5
In-Reply-To: <CACRpkdYgSFYgr-CVmG0JenMM+EOydjJxpR8zaFuGPiMKtKRM9Q@mail.gmail.com>
References: <4F793C56.2030605@st.com>
 <CAOh2x=n8GO-vzFgDEdeyUVdGiOE_-BxgpC5+LbKRMtvgnoSxHQ@mail.gmail.com>
 <CACRpkdZgfY340a5=Mgs0WwTO1e4AiKxv3-xm4pbpEg2jOmiNgg@mail.gmail.com>
 <4F83FAE2.8020107@st.com>
 <CACRpkdbaG0uKeCrAsc8Q4sfY0yY=h48esY=z=Wb8HWHBLK6aVA@mail.gmail.com>
 <4F853FC0.4080802@st.com>
 <CACRpkdYgSFYgr-CVmG0JenMM+EOydjJxpR8zaFuGPiMKtKRM9Q@mail.gmail.com>
Message-ID: <4F854504.2060101@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/11/2012 2:13 PM, Linus Walleij wrote:
> Yeah you can send this pull request and then Arnd or Olof will put it
> on some topic branch like "topic-spear" and then you base your
> further work on top of that and then send a new pull request to be
> merged into that same branch, with the pinctrl stuff. And include the
> ACK:s directly in the patches (git rebase -i is your friend...)

git rebase -i is an old friend, but it seem i don't know him completely :(
How does it help in adding Acked-by automatically? Is there anything more
than marking all of them as "rework" and add these Acks manually?

-- 
viresh
