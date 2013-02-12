From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Feb 2013 13:31:10 +0000
Subject: linux-next: manual merge of the arm-soc tree with the metag tree
In-Reply-To: <20130212145601.09b536bef18ae4f3c8d3b3cc@canb.auug.org.au>
References: <20130212145601.09b536bef18ae4f3c8d3b3cc@canb.auug.org.au>
Message-ID: <201302121331.10646.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 February 2013, Stephen Rothwell wrote:
> Today's linux-next merge of the arm-soc tree got conflicts in
> drivers/clocksource/Makefile and drivers/clocksource/Kconfig between
> commit 3fedb0674fbc ("metag: Time keeping") from the metag tree and
> commits 8a4da6e36c58 ("arm: arch_timer: move core to
> drivers/clocksource") and  ("arm64: move from arm_generic to
> arm_arch_timer") from the arm-soc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).
> 

Thanks, looks good.

	Arnd
