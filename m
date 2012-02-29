From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 29 Feb 2012 18:11:03 +1100
Subject: linux-next: manual merge of the akpm tree with the arm-soc tree
In-Reply-To: <25B60CDC2F704E4E9D88FFD52780CB4C060A87D777@SC-VEXCH1.marvell.com>
References: <20120229172127.7b430cecc7ab2350d4e4a1b8@canb.auug.org.au>
 <20120229063217.GA13386@zhy>
 <25B60CDC2F704E4E9D88FFD52780CB4C060A87D777@SC-VEXCH1.marvell.com>
Message-ID: <20120229181103.e05c55bafd959f739d6a336b@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 28 Feb 2012 22:54:06 -0800 Haojian Zhuang <hzhuang1@marvell.com> wrote:
>
> Since there's the conflict on code. Does it mean that I need to re-submit
> those patches in arm-soc that should be based on commit "drivers/rtc:
> remove IRQF_DISABLED" from the akpm tree?

No, that conflict can be resolved by Linus during the next merge window
(unless someone else wants to do something about it).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120229/f24b067e/attachment.sig>
