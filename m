From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 26 Apr 2012 09:26:48 +0530
Subject: announcing the clk-next branch
In-Reply-To: <CAJOA=zOGSh3et4nxE=JdojL4uDjgt8o+oiOU4pmbM=oU2U6prA@mail.gmail.com>
References: <CAJOA=zOGSh3et4nxE=JdojL4uDjgt8o+oiOU4pmbM=oU2U6prA@mail.gmail.com>
Message-ID: <4F98C780.8020309@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/25/2012 7:02 AM, Turquette, Mike wrote:
> Hi all,
> 
> The clock patches that I have signed-off on and picked from the list
> are all rebased on top of 3.4-rc4.  They can be found here:
> 
> git://git.linaro.org/people/mturquette/linux.git clk-next
> 
> If the branch is missing anything that I have ACK'd then please let me know.
> 
> The obvious thing missing are the recent platform ports.  Those folks
> probably want to test on top of this branch first so it seemed
> premature for me to pull them.  After the recent platform ports go in
> then I'll ask for this to head into linux-next.

I want to understand a bit about how these patches go to linux-next.
Mike would be sleeping right now, so will not disturb him ;)

Arnd,

Can you please help?

Just like Mike, you also asked me to base my patches on an rc release.
Now, few of the dependency patches are there in linux-next that i would need.
Some under my authorship, and some from others. And this number can be 30-50.

Should i ask Mike to apply all of them first and then my patches OR do that
myself and send a pull request. Which would mean all patches, that weren't
related to my patchset also get pushed through my branch. Isn't that a problem?

-- 
viresh
