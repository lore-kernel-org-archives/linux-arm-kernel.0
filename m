From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 19 Jan 2014 09:52:49 +0000
Subject: [RFC v3 00/13] ahci: add sunxi driver and cleanup imx driver
In-Reply-To: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20140119095249.GL15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 19, 2014 at 12:48:42AM +0100, Hans de Goede wrote:
> Hi All,
> 
> Here is v3 of my patchset for adding ahci-sunxi support. It has grown quite
> a bit since I've been going for a more generic approach this time and I've
> also cleaned up the ahci-imx driver to use the same generic approach.

If you want to avoid getting caught in dwmw2's moderation queue, then
please use "[PATCH RFC" and not just "[RFC" for threaded patches.  The
important bit is the "[PATCH" bit.  Thanks.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
