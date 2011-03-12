From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 12 Mar 2011 23:29:51 +0100
Subject: [PATCH 5/8] ARM: PXA: Z2: Add poweroff function
In-Reply-To: <201103122234.01568.anarsoul@gmail.com>
References: <1299839023-16601-1-git-send-email-anarsoul@gmail.com>
	<201103121416.19327.marek.vasut@gmail.com>
	<201103122234.01568.anarsoul@gmail.com>
Message-ID: <201103122329.51319.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 12 March 2011 21:34:01 Vasily Khoruzhick wrote:
> On Saturday 12 March 2011 15:16:19 Marek Vasut wrote:
> > Besides, this is nonsense, you're doing a hack and you're trying to
> > justify it. You cannot powerdown the device, period. You should rather
> > patch the bootloader to implement this para-powerdown behaviour than
> > bloat kernel with this workaround.
> 
> And, btw, there's same code in mainline kernel for zeus machine.

Doesn't mean it's correct. CCing maintainer. Eric, can you also please comment 
on it ? I really don't like the idea of abusing poweroff and making people 
misunderstand.

Cheers
