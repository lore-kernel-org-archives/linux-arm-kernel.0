From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Thu, 3 Jan 2013 16:45:54 +0300
Subject: [PATCH RESEND 6/6] clk: s5p-g2d: Fix incorrect usage of
 IS_ERR_OR_NULL
In-Reply-To: <20130103112102.GM2631@n2100.arm.linux.org.uk>
References: <1355852048-23188-1-git-send-email-linux@prisktech.co.nz>
 <1355852048-23188-7-git-send-email-linux@prisktech.co.nz>
 <50D62BC9.9010706@mvista.com> <50E32C06.5020104@gmail.com>
 <CA+_b7DK2zbBzbCh15ikEAeGP5h-V9gQ_YcX15O-RNvWxCk8Zfg@mail.gmail.com>
 <1357104713.30504.8.camel@gitbox> <20130103090520.GC7247@mwanda>
 <20130103100000.GJ2631@n2100.arm.linux.org.uk>
 <20130103111040.GD7247@mwanda>
 <20130103112102.GM2631@n2100.arm.linux.org.uk>
Message-ID: <20130103134554.GJ7247@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 03, 2013 at 11:21:02AM +0000, Russell King - ARM Linux wrote:
> Maybe you don't realise, but IS_ERR(NULL) is false.  Therefore, this falls
> into category (2).

No, obviously, I know the difference between IS_ERR() and
IS_ERR_OR_NULL().  That's how we started this thread.

*shrug*.

regards,
dan carpenter
