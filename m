From: greg@kroah.com (Greg KH)
Date: Sat, 10 Jan 2015 10:05:32 -0800
Subject: Getting new udev to run with 2.6.28
In-Reply-To: <20150110173920.GA31847@amd>
References: <20150110173920.GA31847@amd>
Message-ID: <20150110180532.GA8566@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 10, 2015 at 06:39:20PM +0100, Pavel Machek wrote:
> Hi!
> 
> N900 has real problems on 3.19, and 2.6.28 should be very well
> debugged version. Getting it to compile on recent distribution was
> fun, but I succeeded. Unfortunately, Debian 7's udev does not work
> with 2.6.28...
> 
> Does anyone have kernel patches to enable modern udev?

Yes, 3.18, please use that instead.

Seriously, lots of things have changed, if you want to run a "new"
version of udev with an old kernel, try eudev, they have been attempting
to keep "legacy" support around in it, don't know how well it has been
working though, you really are on your own.
