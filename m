From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 9 Jun 2017 11:20:01 +0100
Subject: [PATCH v4 2/3] nvmem: add snvs_lpgpr driver
In-Reply-To: <20170609101115.umiaec2qdspkfag3@pengutronix.de>
References: <20170608165134.14971-1-o.rempel@pengutronix.de>
 <20170608165134.14971-3-o.rempel@pengutronix.de>
 <6babaffa-d782-309b-67e4-14dacb72383d@linaro.org>
 <20170609101115.umiaec2qdspkfag3@pengutronix.de>
Message-ID: <8b275308-d379-d78c-dec4-a9e9c6d94332@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/06/17 11:11, Oleksij Rempel wrote:
> And SOC_IMX6 is already doing "select MFD_SYSCON", so I assume it should
> be enough to depend on it.

That should be good enough!!
