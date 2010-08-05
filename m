From: konkers@google.com (Erik Gilling)
Date: Thu, 5 Aug 2010 15:01:43 -0700
Subject: [GIT PULL] Initial Tegra ARM support
In-Reply-To: <1281044755.30969.8.camel@c-dwalke-linux.qualcomm.com>
References: <AANLkTi=dcQrik=+5xfwbNo_w7WkTOKZiKAFYFhwzbS=_@mail.gmail.com>
	<1281044755.30969.8.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <AANLkTimZYveOZLoDS82z0nosAHa21ChHCK1GpophEQ1P@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If these changes went through Russell's tree there would be
dependancies on arch/arm/mach-tegra/(Makefile|Kconfig) in
arch/arm/(Makefile|Kconfig) breaking Russell's tree until it was
merged with the tegra tree.  That sounds wrong to me.  Additionally
these patches have received review on LAKML including some by Russell
and nothing was mentioned about this being a problem.

There is a conflict on these against linux/master.  I'm rebasing now for Linus.

-Erik

On Thu, Aug 5, 2010 at 2:45 PM, Daniel Walker <dwalker@codeaurora.org> wrote:
> On Thu, 2010-08-05 at 14:10 -0700, Erik Gilling wrote:
>> ?arch/arm/Kconfig ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? | ? 25 +-
>> ?arch/arm/Makefile ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| ? ?1 +
>
> In the future could you please send changes to arch/arm/Kconfig and
> arch/arm/Makefile to Russell .. That way there's no chance for conflicts
> with other -next trees.
>
> Daniel
> --
> Sent by an consultant of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
>
>
