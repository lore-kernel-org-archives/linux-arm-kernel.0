From: shiraz.hashim@st.com (Shiraz Hashim)
Date: Wed, 11 Apr 2012 14:34:34 +0530
Subject: [GIT PULL] ARM: spear-soc DT support for 3.5
In-Reply-To: <CACRpkdaU8yVAnsvL3JBh-XZv0pQ0jtdDOz97nF2v7LbQoYRz_g@mail.gmail.com>
References: <4F793C56.2030605@st.com>
 <CAOh2x=n8GO-vzFgDEdeyUVdGiOE_-BxgpC5+LbKRMtvgnoSxHQ@mail.gmail.com>
 <CACRpkdZgfY340a5=Mgs0WwTO1e4AiKxv3-xm4pbpEg2jOmiNgg@mail.gmail.com>
 <4F83FAE2.8020107@st.com>
 <CACRpkdbaG0uKeCrAsc8Q4sfY0yY=h48esY=z=Wb8HWHBLK6aVA@mail.gmail.com>
 <4F853FC0.4080802@st.com>
 <CACRpkdYgSFYgr-CVmG0JenMM+EOydjJxpR8zaFuGPiMKtKRM9Q@mail.gmail.com>
 <4F854504.2060101@st.com>
 <CACRpkdaU8yVAnsvL3JBh-XZv0pQ0jtdDOz97nF2v7LbQoYRz_g@mail.gmail.com>
Message-ID: <20120411090434.GX1781@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 04:54:01PM +0800, Linus Walleij wrote:
> On Wed, Apr 11, 2012 at 10:47 AM, Viresh Kumar <viresh.kumar@st.com> wrote:
> > On 4/11/2012 2:13 PM, Linus Walleij wrote:
> >> Yeah you can send this pull request and then Arnd or Olof will put it
> >> on some topic branch like "topic-spear" and then you base your
> >> further work on top of that and then send a new pull request to be
> >> merged into that same branch, with the pinctrl stuff. And include the
> >> ACK:s directly in the patches (git rebase -i is your friend...)
> >
> > git rebase -i is an old friend, but it seem i don't know him completely :(
> > How does it help in adding Acked-by automatically? Is there anything more
> > than marking all of them as "rework" and add these Acks manually?
> 
> Not that I'm aware of ... That's how I do it atleast.

In your 'git party' I remember, someone mentioning about 'git
filter-branch' which can help on this. Perhaps we need to go through
the help pages.

--
regards
Shiraz
