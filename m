From: felipe.balbi@nokia.com (Felipe Balbi)
Date: Tue, 29 Dec 2009 14:54:03 +0200
Subject: [PATCH RFC 1/2] MUSB: CPPI 4.1 DMA driver (take 4)
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044A2779F6@dbde02.ent.ti.com>
References: <19F8576C6E063C45BE387C64729E7394044A2779F5@dbde02.ent.ti.com>
	<19F8576C6E063C45BE387C64729E7394044A2779F6@dbde02.ent.ti.com>
Message-ID: <20091229125403.GD17147@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 29, 2009 at 09:43:49AM +0100, ext Gupta, Ajay Kumar wrote:
>As this discussion is taking time which is affecting the further
>development and bug fixes on CPPI4.1.
>
>So can we move CPPI4.1 files to drivers/usb/musb for time being and submit
>a replacement patch whenever we all agree on the location of CPPI4.1
>related files.

problem is that once it's applied, no-one seems to care anymore. And 
it'll be there for good. Better is to decide what really is the correct 
place for this otherwise it'll be like tusb6010_omap.c

-- 
balbi
