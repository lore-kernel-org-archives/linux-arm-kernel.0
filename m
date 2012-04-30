From: viresh.linux@gmail.com (viresh kumar)
Date: Mon, 30 Apr 2012 21:46:41 +0530
Subject: announcing the clk-next branch
In-Reply-To: <201204301441.39191.arnd.bergmann@linaro.org>
References: <CAJOA=zOGSh3et4nxE=JdojL4uDjgt8o+oiOU4pmbM=oU2U6prA@mail.gmail.com>
 <4F98C780.8020309@st.com>
 <201204301441.39191.arnd.bergmann@linaro.org>
Message-ID: <CAOh2x==aTftkv-2agaU873sp5LZhBjLmwYuW9QJm3Rvt+fZ3gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 30, 2012 at 8:11 PM, Arnd Bergmann <arnd.bergmann@linaro.org> wrote:
> Sorry for the late reply on my side. I'm not sure if I understand your
> question correctly. Generally the rule is to not apply the same patch to
> two separate branches because that can result in merge conflicts and/or an
> unclean history.

No Probs.

> The way to deal with dependencies in a case like this is to apply the patches
> on one branch in the right order and ask different people to include parts of
> that branch in their trees without rebasing.
>
> For instance, you can take Mike's branch as a base (as long as he promises
> to never rebase that branch), add some patches on top and ask him to pull that
> commit with your additional clk patches. Then you add other patches for arm-soc
> on top of that and ask me to pull that branch, including the clk commits that
> originally came from Mike.
>
> I can then pull the branch into one of the arm-soc branches that gets sent to
> Linus after the clk tree was merged into v3.5-rc1.
>
> It also works the other way round: You can base on top of patches that are
> already in arm-soc, add more stuff that should go into arm-soc on top, and
> add clk patches for Mike on top of that, which means that in the end, the
> arm-soc tree has to go to Linus before the clk tree does.
>
> The tricky part here is to avoid circular dependencies.

Can you please check my new PULL requests sent few minutes back.
I hope, i haven't done anything wrong this time. :)

--
viresh
