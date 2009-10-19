From: daniel@caiaq.de (Daniel Mack)
Date: Mon, 19 Oct 2009 15:38:01 +0200
Subject: Ext3 is supported not well at 2.6.28 for external SD card
	removal
In-Reply-To: <28376653.255741255932756974.JavaMail.coremail@bj126app18.126.com>
References: <200910190759.11591.marek.vasut@gmail.com>
	<4ADBFB5B.9030200@gmail.com>
	<28376653.255741255932756974.JavaMail.coremail@bj126app18.126.com>
Message-ID: <20091019133801.GL28832@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2009 at 02:12:36PM +0800, tommy.hong wrote:
> hi,you can try EXT4!ext3 is not stable in arm,one of my friends need some ext3 bug in 2.6.25,can cause system halt!

What kind of bug are you referring to? Did you speak to the vfs/ext3
people about that?

We've been using ext3 on ARM on mass storage media for quite some time,
without facing any serious issues.

Daniel
