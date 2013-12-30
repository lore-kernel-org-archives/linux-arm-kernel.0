From: broonie@kernel.org (Mark Brown)
Date: Mon, 30 Dec 2013 12:58:45 +0000
Subject: [PATCH v2 6/8] [RFC] Documentation: dt: Add Renesas RSPI/QSPI
 bindings
In-Reply-To: <1388175362-17132-7-git-send-email-geert@linux-m68k.org>
References: <1388175362-17132-1-git-send-email-geert@linux-m68k.org>
 <1388175362-17132-7-git-send-email-geert@linux-m68k.org>
Message-ID: <20131230125845.GX31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 27, 2013 at 09:16:00PM +0100, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> Cc: devicetree at vger.kernel.org

You've not CCed any maintainers on any of this stuff so I'm assuming you
don't want any review or the patches applying.  You should in general
always CC maintainers, things that only go to the list can easily be
missed.  However I did take a brief look...

> +- num-cs	   : Number of chip selects

Why is this variable and how does this map onto hardware?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131230/d23a6495/attachment-0001.sig>
