From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 14 May 2015 11:15:19 +0100
Subject: [PATCH] ARM: mm: handle non-pmd-aligned end of RAM
In-Reply-To: <20150513141152.GD6169@leverpostej>
References: <a865bd68d706f8c4c9e82a374ff6adc4@agner.ch>
 <20150511103130.GA3490@leverpostej>
 <5dec6ce1e05fd20c214d9e0ab41dcc0d@agner.ch>
 <55535440.1090808@redhat.com> <20150513141152.GD6169@leverpostej>
Message-ID: <20150514101519.GX2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 13, 2015 at 03:11:52PM +0100, Mark Rutland wrote:
> Russell, on the assumption you're ok with the patch I've submitted it to
> the patch system as 8356/1.

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
