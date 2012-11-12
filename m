From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Mon, 12 Nov 2012 17:17:35 +0200
Subject: [PATCH v3 1/3] mtd: sh_flctl: Minor cleanups
In-Reply-To: <1350641736-18192-2-git-send-email-hechtb@gmail.com>
References: <1350641736-18192-1-git-send-email-hechtb@gmail.com>
 <1350641736-18192-2-git-send-email-hechtb@gmail.com>
Message-ID: <1352733455.2262.0.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-10-19 at 12:15 +0200, Bastian Hecht wrote:
> Some small fixes to avoid sparse and smatch complain. Other cosmetic fixes
> as well.
> 
> - Change of the type of the member index in struct sh_flctl from signed
> to unsigned. We use index by addressing array members, so unsigned is more
> concise here. Adapt functions relying on sh_flctl::index.
> - Remove a blurring cast in write_fiforeg().
> - Apply consistent naming scheme when refering to the data buffer.
> - Shorten some unnecessarily verbose functions.
> - Remove spaces at start of lines.
> 
> Signed-off-by: Bastian Hecht <hechtb@gmail.com>

Pushed to l2-mtd.git, thanks!

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121112/9f95731c/attachment.sig>
