From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Jan 2010 18:00:10 +0000
Subject: spitz (arm pda): time no longer ok after resume
In-Reply-To: <20100127171308.GA24875@ucw.cz>
References: <20100127171308.GA24875@ucw.cz>
Message-ID: <20100127180010.GA22660@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2010 at 06:13:08PM +0100, Pavel Machek wrote:
> It seems that spitz has problems with time after resume; time while it
> was sleeping is not accounted. This seems to be regression in
> 2.6.33-rc5.

No rtc configured/loaded?
