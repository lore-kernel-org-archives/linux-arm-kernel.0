From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 1 Sep 2013 14:02:15 +0100
Subject: [alsa-devel] [PATCH 00/14] SPDIF support
In-Reply-To: <20130901123433.GR6617@n2100.arm.linux.org.uk>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <52220B9A.9000007@metafoo.de> <20130831172853.GL18608@sirena.org.uk>
 <20130831191956.GH6617@n2100.arm.linux.org.uk> <5222562B.8010001@metafoo.de>
 <20130831210518.GK6617@n2100.arm.linux.org.uk>
 <20130901121928.GC3084@sirena.org.uk>
 <20130901123433.GR6617@n2100.arm.linux.org.uk>
Message-ID: <20130901130215.GS6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 01, 2013 at 01:34:33PM +0100, Russell King - ARM Linux wrote:
> The non-DT support I run has full support for everything on Dove, which
> means I can do much more in-depth testing than just running madplay or
> something similar to check that there's audio out - which is about the
> limit of what can be done with DT-only setups at the moment, such as
> the DPCM bug triggered by vlc.

Sorry, that was a bit unclear: I meant that I can do testing with vlc
on my setup, which I don't believe to be possible yet on DT setups.
