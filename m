From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 17 Sep 2009 13:06:00 +0300
Subject: [PATCH] Samsung SoCs: OneNAND support
In-Reply-To: <9c9fda240909170302q47b306edn2d73b03243757ce1@mail.gmail.com>
References: <20090917081659.GA28591@july> <4AB1F3C5.7000309@gmail.com>
	<9c9fda240909170245u2b21b898v11c3316726746464@mail.gmail.com>
	<9c9fda240909170302q47b306edn2d73b03243757ce1@mail.gmail.com>
Message-ID: <1253181960.3778.17.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2009-09-17 at 19:02 +0900, Kyungmin Park wrote:
> >> Very quick comment. Could you please avoid this style of putting function
> >> name to the printk? We have lots of this in onenand_base.c, and they are
> >> often wrong, because function names change.
> >>
> >> Could we please use dev_printk(), dev_dbg() and the like instead? You'll
> 
> FYI: In case of MTD,
> dev_printk(), dev_dbg() not working. I used &mtd->dev,
> 
> Do you know how to set the dev instead of &mtd->dev?

No, but you could investigate this.

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
