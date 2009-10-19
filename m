From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Oct 2009 16:03:21 +0100
Subject: Ext3 is supported not well at 2.6.28 for external SD card
	removal
In-Reply-To: <28376653.255741255932756974.JavaMail.coremail@bj126app18.126.com>
References: <200910190759.11591.marek.vasut@gmail.com>
	<4ADBFB5B.9030200@gmail.com>
	<28376653.255741255932756974.JavaMail.coremail@bj126app18.126.com>
Message-ID: <20091019150321.GE13614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2009 at 02:12:36PM +0800, tommy.hong wrote:
> hi,you can try EXT4!ext3 is not stable in arm,one of my friends need
> some ext3 bug in 2.6.25,can cause system halt!

ext3 works fine - it's been used on the old mailing list server for its
filesystems for hundreds of days (on that exact kernel version) without
issue.

It's also being used on the web server and older web server both without
any incident.

All aforementioned machines are ARM based.  I can only assume that you
have local (unreported) issues with ext3 on ARM.
