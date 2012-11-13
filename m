From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 13 Nov 2012 07:37:39 -0500
Subject: [PATCH] ARM: kirkwood: Add Plat'Home OpenBlocks A6 support
In-Reply-To: <1352792590-20052-1-git-send-email-iwamatsu@nigauri.org>
References: <1352792590-20052-1-git-send-email-iwamatsu@nigauri.org>
Message-ID: <20121113123739.GS22042@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nobuhiro,

On Tue, Nov 13, 2012 at 04:43:09PM +0900, Nobuhiro Iwamatsu wrote:
> Add support for Plat'Home OpenBlocks A6 using the device tree
> where possible.
> This commit supports SATA, USB, ether and serial console.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---
> V2: 
>   - Remove unnecessary value from bootargs.
>   - Update comment for MPP table.
>   - Remove kirkwood_uart0_init().

Thanks for the patch.  One small note.  In the future, please add a 'V2'
to the subject line, eg "[PATCH V2] ...".  It really helps us keep track of
which one to merge.

No need to resend, I'll keep track of it since I'm about to pull
everything together over the next few days.

thx,

Jason.
