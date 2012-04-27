From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 27 Apr 2012 11:44:50 +0530
Subject: announcing the clk-next branch
In-Reply-To: <CAJOA=zOGSh3et4nxE=JdojL4uDjgt8o+oiOU4pmbM=oU2U6prA@mail.gmail.com>
References: <CAJOA=zOGSh3et4nxE=JdojL4uDjgt8o+oiOU4pmbM=oU2U6prA@mail.gmail.com>
Message-ID: <4F9A395A.3030306@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/25/2012 7:02 AM, Turquette, Mike wrote:
> The obvious thing missing are the recent platform ports.  Those folks
> probably want to test on top of this branch first so it seemed
> premature for me to pull them.  After the recent platform ports go in
> then I'll ask for this to head into linux-next.

Hi Mike and others,

I am finding difficulty in creating branch to be pulled in by Mike for clock
stuff. Somebody please help.

SPEAr patches have dependency on few patchsets that are pulled in linux-next
already.
- SPEAr DT support
- SPEAr Pinctrl support
- Mike clk fixes
- Misc Pinctrl patches

Now, how should i create branch for SPEAr clk stuff over these dependencies?
I tried to create a merge of first 3, but couldn't get a linux-next/master
sha of a branch for Last dependency.

Should i cherrypick that one?

At last, i believe this branch, that i would create, must be in a compilable
state? So, i can't just send a pull request for my clock patches rebased over
Mike's branch directly?

-- 
viresh
