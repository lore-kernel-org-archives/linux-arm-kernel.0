From: tony@atomide.com (Tony Lindgren)
Date: Mon, 15 Feb 2016 11:57:53 -0800
Subject: Crashes in arm qemu emulations due to 'cpufreq: governor:
 Replace timers with utilization ...'
In-Reply-To: <20160215194627.GA25882@roeck-us.net>
References: <20160215170527.GA24453@roeck-us.net> <56C22105.6050900@arm.com>
 <CAJZ5v0gXGzzJ7CcbgNNO-ULrtd9Z2hbqHeuXRYJLFLrh+BWVWA@mail.gmail.com>
 <1508162.Id3YElPxB2@vostro.rjw.lan>
 <20160215194227.GY19432@atomide.com>
 <20160215194627.GA25882@roeck-us.net>
Message-ID: <20160215195752.GZ19432@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Guenter Roeck <linux@roeck-us.net> [160215 11:47]:
> On Mon, Feb 15, 2016 at 11:42:27AM -0800, Tony Lindgren wrote:
> > * Rafael J. Wysocki <rjw@rjwysocki.net> [160215 11:28]:
> > > 
> > > Guenter, Tony,
> > > 
> > > Below is a patch to try, on top of linux-next.
> > 
> > Fixes the issue on UP for me:
> > 
> > Tested-by: Tony Lindgren <tony@atomide.com>
> > 
> > > Please let me know if the problem is still around with that patch applied.
> > 
> > It seems we still have another issue with SMP systems, see below.
> > 
> Try https://patchwork.kernel.org/patch/8318221

Great, that one fixes the SMP issue for me. So for patchwork
patch 8318221, here's a cross thread tested-by as looks like
I was not on Cc for it:

Tested-by: Tony Lindgren <tony@atomide.com>
