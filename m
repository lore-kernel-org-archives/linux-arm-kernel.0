From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 21 Oct 2013 09:55:03 -0400
Subject: DreamPlug / GuruPlug support in 3.12-rc
In-Reply-To: <526519DC.5030500@gmail.com>
References: <5263C7C2.4000204@gmail.com>
 <20131020161747.GA15169@titan.lakedaemon.net>
 <5264382E.9050207@gmail.com>
 <20131020215017.GD15169@titan.lakedaemon.net>
 <526519DC.5030500@gmail.com>
Message-ID: <20131021135503.GH15169@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert,

On Mon, Oct 21, 2013 at 01:11:08PM +0100, robert wrote:
> My error in logic was to base my testing on a kernel config which seemed
> - to me - to 'work', but was actually _incorrect_, as you pointed out.

whew!  I'm glad it was something simple and not a bug in the code.

> I decided to scrub the existing config, and start over, from # make
> kirkwood_defconfig, and then select/deselect options for the
> DreamPlug.    After a bit of trial and error, I now have a working
> 3.12-rc6 system:

For future reference, we've been keeping the relevant _defconfig's up
to date so that they build each new version of the kernel, and, if we're
doing our jobs correctly, the resulting kernel should boot without
trouble.  If it fails, please let us know.

> Many thanks for your help.

Anytime.

thx,

Jason.
