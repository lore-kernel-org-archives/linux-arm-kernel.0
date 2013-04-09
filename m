From: linux@prisktech.co.nz (Tony Prisk)
Date: Tue, 09 Apr 2013 21:04:50 +1200
Subject: linux-next: manual merge of the arm-soc tree with the gpio-lw tree
In-Reply-To: <20130409174747.873a9c9cad1cd6a4dbe4014f@canb.auug.org.au>
References: <20130409174747.873a9c9cad1cd6a4dbe4014f@canb.auug.org.au>
Message-ID: <5163D9B2.9060603@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/04/13 19:47, Stephen Rothwell wrote:
> Hi all,
>
> Today's linux-next merge of the arm-soc tree got a conflict in
> drivers/gpio/gpio-vt8500.c between commit 808c513ee64b ("gpio/vt8500:
> Convert to devm_ioremap_resource()") from the gpio-lw tree and commit
> dc1010860b03 ("gpio: vt8500: Remove arch-vt8500 gpio driver") from the
> arm-soc tree.
>
> The latter removed the file, so I did that and can carry the fix as
> necessary (no action is required).
>
That's the correct solution

Regards
Tony P
