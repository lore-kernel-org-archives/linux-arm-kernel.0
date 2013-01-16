From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Wed, 16 Jan 2013 10:48:21 +0100
Subject: [PATCH  0/5] W1: Support onewire master on i.MX53
Message-ID: <20130116094821.9660.18278.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W1: Support onewire master on i.MX53
	* Add device tree and pinctrl support to the MXC master driver
	* Add i.MX53 clocks
	* Add i.MX53 device tree entries

The final patch converts the driver to use devm_
