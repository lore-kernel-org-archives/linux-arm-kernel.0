From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 03 Feb 2015 10:25:05 -0800
Subject: linux-next: manual merge of the clk tree with the arm-soc tree
In-Reply-To: <20150203163140.3edfe607@canb.auug.org.au>
References: <20150203163140.3edfe607@canb.auug.org.au>
Message-ID: <20150203182505.421.11849@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Rothwell (2015-02-02 21:31:40)
> Hi Mike,
> 
> Today's linux-next merge of the clk tree got a conflict in
> arch/arm/mach-omap2/cclock3xxx_data.c between commit ca662ee7b8a8
> ("ARM: OMAP2+: Remove unused ti81xx platform init code") from the
> arm-soc tree and commit d6540b193719 ("ARM: OMAP3: remove legacy clock
> data") from the clk tree.
> 
> I fixed it up (the latter removed the file, so I did that) and can
> carry the fix as necessary (no action is required).

That is the correct fix.

Thanks,
Mike

> 
> -- 
> Cheers,
> Stephen Rothwell                    sfr at canb.auug.org.au
