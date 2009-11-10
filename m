From: greg@kroah.com (Greg KH)
Date: Mon, 9 Nov 2009 21:16:03 -0800
Subject: [REPOST PATCH 1/3] MXC: Add i.MX21 specific USB host
	controller driver.
In-Reply-To: <20091108185222.14742.11572.stgit@srv002.fuzzey.net>
References: <20091108185217.14742.32892.stgit@srv002.fuzzey.net>
	<20091108185222.14742.11572.stgit@srv002.fuzzey.net>
Message-ID: <20091110051603.GA27314@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 08, 2009 at 07:52:22PM +0100, Martin Fuzzey wrote:
> This driver is a Full / Low speed only USB host for the i.MX21.

I didn't notice anything objectionable here, but host controller drivers
are not my speciality.  If it's working for you, that is a good reason
to get it in for wider testing.

thanks,

greg k-h
