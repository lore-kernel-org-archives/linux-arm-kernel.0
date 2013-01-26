From: balbi@ti.com (Felipe Balbi)
Date: Sat, 26 Jan 2013 10:46:04 +0200
Subject: OMAP baseline test results for v3.8-rc5
In-Reply-To: <alpine.DEB.2.00.1301260838300.19277@utopia.booyaka.com>
References: <alpine.DEB.2.00.1301260838300.19277@utopia.booyaka.com>
Message-ID: <20130126084604.GB8754@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Jan 26, 2013 at 08:40:07AM +0000, Paul Walmsley wrote:
> Boot tests:
> 
> * am335xbone: hangs after "Starting kernel"
>   - Cause unknown; may be due to CONFIG_EARLY_PRINTK=y?
>   - http://www.mail-archive.com/linux-omap at vger.kernel.org/msg82297.html
>   - http://marc.info/?l=linux-omap&m=135903184512238&w=2

FYI, I don't think it's related to CONFIG_EARLY_PRINTK. Tested with and
without it, also removed CONFIG_DEBUG_LL completely and nothing seemed
to help my bone, no matter if I had appended DTB or not.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130126/ef147159/attachment-0001.sig>
