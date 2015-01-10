From: svenjoac@gmx.de (Sven Joachim)
Date: Sat, 10 Jan 2015 20:54:54 +0100
Subject: Getting new udev to run with 2.6.28
In-Reply-To: <20150110180942.GA10142@amd> (Pavel Machek's message of "Sat, 10
 Jan 2015 19:09:42 +0100")
References: <20150110173920.GA31847@amd> <20150110180532.GA8566@kroah.com>
 <20150110180942.GA10142@amd>
Message-ID: <87a91q2yy9.fsf@turtle.gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-01-10 19:09 +0100, Pavel Machek wrote:

> I was hoping someone has devtmpfs patches I could just apply over
> 2.6.28 and get a working system?

IIRC the udev version in Debian 7 does not require devtmpfs (that became
mandatory only in udev 176), but kernel 2.6.32 or higher is required for
other reasons.  See commit 67a77c8bf299f6264f001677becd056316ebce2f in
udev[1].

Cheers,
       Sven


1. https://git.kernel.org/cgit/linux/hotplug/udev.git/commit/?id=67a77c8bf299f6264f001677becd056316ebce2f
