From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 1 May 2012 09:10:47 +0530
Subject: [GIT PULL] ARM: SPEAr13xx support for 3.5
In-Reply-To: <201204301746.45004.arnd@arndb.de>
References: <CAOh2x==Dh5thHoQaQ+eN34oeWsmZ32kMOOQ6nU5kO7Tfcr=PUA@mail.gmail.com>
 <201204301746.45004.arnd@arndb.de>
Message-ID: <4F9F5B3F.1030502@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/30/2012 11:16 PM, Arnd Bergmann wrote:
> Ok, I missed the compilation dependencies you mentioned here.  So the branch
> you sent me doesn't actually build by itself, which is not good.

I thought, i must not add patches from Russell and Mike in my pull request, as they
haven't made to linux-next till now. i.e. even if this branch doesn't compile by
itself, it should get compiled when it is merged with your branch, where these
dependencies must be present already. Isn't this the right approach?

> I have now merged both as staging branches, which means it will be in linux-next
> from now on but can still get rebased in order to work out the dependencies.

Ok.

> We can work out something from here once I understand where the dependencies
> are.

These two only:

- Mike's clk-next branch
- Russell's: CLKDEV: Add helper routines to allocate and add clkdevs for ...

-- 
viresh
