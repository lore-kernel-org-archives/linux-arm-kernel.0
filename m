From: tony@atomide.com (Tony Lindgren)
Date: Thu, 20 Sep 2012 15:01:44 -0700
Subject: linux-next: manual merge of the arm-soc tree with the
 sound-asoc tree
In-Reply-To: <20120920160637.7f9065225982468c25fa1952@canb.auug.org.au>
References: <20120920160637.7f9065225982468c25fa1952@canb.auug.org.au>
Message-ID: <20120920220143.GI28835@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Rothwell <sfr@canb.auug.org.au> [120919 23:07]:
> Hi all,
> 
> Today's linux-next merge of the arm-soc tree got conflicts in
> sound/soc/omap/igep0020.c, sound/soc/omap/omap3beagle.c,
> sound/soc/omap/omap3evm.c and sound/soc/omap/overo.c between commit
> 152c6e56f6a8 ("ASoC: Remove obsolete OMAP3 machine drivers") from the
> sound-asoc tree and commit 2203747c9771 ("ARM: omap: move platform_data
> definitions") from the arm-soc tree.
> 
> The former removed the files, so I did that and can carry the fix as
> necessary (no action is required).

OK thanks again.

Tony
