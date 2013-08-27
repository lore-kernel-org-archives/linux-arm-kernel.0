From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 27 Aug 2013 08:30:32 -0700
Subject: linux-next: manual merge of the arm-soc tree with the pm tree
In-Reply-To: <20130827183313.aa7d51c6dd0b21cd8168aa35@canb.auug.org.au>
 (Stephen Rothwell's message of "Tue, 27 Aug 2013 18:33:13 +1000")
References: <20130827183313.aa7d51c6dd0b21cd8168aa35@canb.auug.org.au>
Message-ID: <87wqn7w3qf.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> Today's linux-next merge of the arm-soc tree got a conflict in
> arch/arm/mach-mvebu/platsmp.c between commit f6cec7cd0777 ("ARM: mvebu:
> remove device tree parsing for cpu nodes") from the  tree and commit
> 994c8c94b419 ("ARM: mvebu: Remove the harcoded BootROM window
> allocation") from the arm-soc tree.
>
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).

Fix looks correct, thanks.

Kevin (for arm-soc folks)
