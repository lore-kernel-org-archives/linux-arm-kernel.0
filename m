From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Fri, 18 May 2012 14:54:23 +0300
Subject: [PATCH v7 3/3] MTD: atmel_nand: Update driver to support
 Programmable Multibit ECC controller
In-Reply-To: <20120517125544.GJ9571@n2100.arm.linux.org.uk>
References: <1337093256-19117-1-git-send-email-josh.wu@atmel.com>
 <1337093256-19117-4-git-send-email-josh.wu@atmel.com>
 <1337160353.24809.26.camel@sauron.fi.intel.com>
 <20403.29677.517067.528042@ipc1.ka-ro>
 <1337161217.24809.38.camel@sauron.fi.intel.com>
 <4FB49C60.5030002@atmel.com> <1337255011.2564.2.camel@koala>
 <20120517125544.GJ9571@n2100.arm.linux.org.uk>
Message-ID: <1337342063.2483.37.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-05-17 at 13:55 +0100, Russell King - ARM Linux wrote:
> > You can just remove the backslashes. I think your lines splitting is
> > fine otherwise.
> 
> It's also preferred _not_ to wrap error messages as that makes them
> harder to grep for.  Linus has mentioned this several times on LKML
> and has corrected error messages that he encounters that he can't
> find via grep.

OK, thanks for the info.

One could argue that it probably only makes sense to avoid splitting up
to the first %d or another printk placeholder. Beyond the placeholder
grepping is not more difficult.

Well, anyway, I would not like to force people to split or not split
strings. I'd also say that it is more important to follow the style of
the driver/subsystem and be consistent.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120518/3d47ab6c/attachment.sig>
