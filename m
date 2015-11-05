From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 5 Nov 2015 01:27:07 +0100
Subject: [PATCH 2/4] ARM: dts: kirkwood: add Linksys EA3500
In-Reply-To: <00000150d49a832c-f77d66d7-8f66-4b36-ac2c-df85deee46b6-000000@email.amazonses.com>
References: <1446675888-24495-1-git-send-email-luka.perkov@sartura.hr>
 <00000150d49a832c-f77d66d7-8f66-4b36-ac2c-df85deee46b6-000000@email.amazonses.com>
Message-ID: <20151105002707.GB8942@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 04, 2015 at 10:25:07PM +0000, Luka Perkov wrote:
> Based on dts files from OpenWrt.

Hi Luka

Thanks for spending the time to submit these upstream.

It looks like a lot of the same comments apply to these files, so i
won't keep repeat them.

One thing i did notice is that turning off the internal RTC is common,
but there is no i2c RTC. Is this correct? Do these devices not have an
RTC?
	Thanks
		Andrew
