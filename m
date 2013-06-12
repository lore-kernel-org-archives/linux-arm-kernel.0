From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 12 Jun 2013 13:38:29 +0300
Subject: [PATCH 0/3] ARM: OMAP: add corrected DSS regulator supplies
In-Reply-To: <1369985874-8571-1-git-send-email-tomi.valkeinen@ti.com>
References: <1369985874-8571-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <51B84FA5.80409@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/05/13 10:37, Tomi Valkeinen wrote:
> Hi Tony,
> 
> Here are a few patches adding corrected DSS regulator supplies. The current
> ones in the board files are not really correct, although the dss driver works
> ok with them.
> 
> So these patches add new regulator supply entries. When these are merged, I'll
> change omapdss driver to use the new ones, instead of the old ones. After that,
> we can remove the old ones from the board files.
> 
> Note that these patches were also present in the big DSS series I sent
> yesterday. There's no reason for these patches to be there, so I'm sending them
> separately, and will drop these from my DSS series.

Ping.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130612/9d11bedf/attachment.sig>
