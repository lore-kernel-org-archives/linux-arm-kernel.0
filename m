From: zbr@ioremap.net (Evgeniy Polyakov)
Date: Wed, 16 Jan 2013 18:17:54 +0400
Subject: [PATCH  0/5] W1: Support onewire master on i.MX53
In-Reply-To: <20130116094821.9660.18278.stgit@localhost>
References: <20130116094821.9660.18278.stgit@localhost>
Message-ID: <20130116141754.GB23638@ioremap.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Wed, Jan 16, 2013 at 10:48:21AM +0100, Martin Fuzzey (mfuzzey at parkeon.com) wrote:
> W1: Support onewire master on i.MX53
> 	* Add device tree and pinctrl support to the MXC master driver
> 	* Add i.MX53 clocks
> 	* Add i.MX53 device tree entries
> 
> The final patch converts the driver to use devm_

Looks good to me, thank you
Acked-by: Evgeniy Polyakov <zbr@ioremap.net>

-- 
	Evgeniy Polyakov
