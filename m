From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Sat, 10 Jan 2015 21:13:35 +0200
Subject: Getting new udev to run with 2.6.28
In-Reply-To: <20150110173920.GA31847@amd>
References: <20150110173920.GA31847@amd>
Message-ID: <20150110191335.GA5125@fuloong-minipc.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Jan 10, 2015 at 06:39:20PM +0100, Pavel Machek wrote:
> N900 has real problems on 3.19, and 2.6.28 should be very well
> debugged version. Getting it to compile on recent distribution was
> fun, but I succeeded. Unfortunately, Debian 7's udev does not work
> with 2.6.28...

I guess you will have many other issues too if you want to run
such combination (legacy kernel + modern userspace). E.g. current glibc
requires >= 2.6.32.

A.
