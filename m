From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 04 Apr 2013 18:23:37 +0300
Subject: [PATCH 1/4] mtd: merge mtdchar module with mtdcore
In-Reply-To: <20130317215805.3246b0b5.shmulik.ladkani@gmail.com>
References: <1363260463-10609-1-git-send-email-dedekind1@gmail.com>
 <20130317215805.3246b0b5.shmulik.ladkani@gmail.com>
Message-ID: <1365089017.626.14.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2013-03-17 at 21:58 +0200, Shmulik Ladkani wrote:
> On Thu, 14 Mar 2013 13:27:40 +0200 Artem Bityutskiy <dedekind1@gmail.com> wrote:
> > Indeed, mtdchar is a module that allows user-space making use of MTD devices
> > via /dev/mtd* character devices. If users do not enable it, they simply cannot
> > use MTD devices at all. The cannot read or write the flash contents. Is it a
> 
> s/ The cannot/ They cannot/

Fixed.

> What about the defconfig files?

There are too many of them. I do not want to update them because it is
not necessary and the non-existing symbol will just be ignored by
Kbuild. People who support their defconfigs will eventually update them
eventually.

-- 
Best Regards,
Artem Bityutskiy
