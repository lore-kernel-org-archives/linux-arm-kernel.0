From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 5 May 2014 13:47:11 -0700
Subject: [PATCH 3.14 012/158] ARM: dts: am33xx: correcting dt node unit
 address for usb
In-Reply-To: <20140505083757.GB30739@localhost>
References: <20140504154029.975081050@linuxfoundation.org>
 <20140504154031.690140742@linuxfoundation.org>
 <20140505083757.GB30739@localhost>
Message-ID: <20140505204711.GC18222@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 05, 2014 at 10:37:57AM +0200, Johan Hovold wrote:
> On Sun, May 04, 2014 at 11:38:41AM -0400, Greg Kroah-Hartman wrote:
> > 3.14-stable review patch.  If anyone has any objections, please let me know.
> 
> This one should not be backported without commit
> 
> 	a2f8d6b30321 ("ARM: dts: am335x: update USB DT references")
> 
> which is in Linus' tree but is not marked for stable (or USB will be
> disabled for the boards relying on the old node addresses).

Thanks for letting me know, I've now applied that patch as well.

greg k-h
