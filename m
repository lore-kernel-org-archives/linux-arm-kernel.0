From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Mar 2015 16:00:08 +0000
Subject: [PATCH 2/3] pm: domains: factor out code to get the generic PM
 domain from a struct device
In-Reply-To: <20150326152043.GL8656@n2100.arm.linux.org.uk>
References: <20150320171941.GK8656@n2100.arm.linux.org.uk>
 <CAPDyKFrpM0TYnNvAX8Jw6zUAekh0=XXMJyxWxSgKSao=TQf62Q@mail.gmail.com>
 <20150323151740.GR8656@n2100.arm.linux.org.uk>
 <5429586.AxdftPXcBp@vostro.rjw.lan>
 <20150326152043.GL8656@n2100.arm.linux.org.uk>
Message-ID: <20150326160007.GP8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 26, 2015 at 03:20:43PM +0000, Russell King - ARM Linux wrote:
> I'll replicate what you've applied and test it here (build in progress...)

It looks like it works as desired.

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
