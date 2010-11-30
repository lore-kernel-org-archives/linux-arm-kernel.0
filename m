From: tbm@cyrius.com (Martin Michlmayr)
Date: Tue, 30 Nov 2010 15:54:58 +0000
Subject: [PATCH] Kirkwood: Add support for 6282 based QNAP devices
In-Reply-To: <19700.59967.284644.290002@pilspetsen.it.uu.se>
References: <20101129174440.GA14799@jirafa.cyrius.com>
	<19700.59967.284644.290002@pilspetsen.it.uu.se>
Message-ID: <20101130155457.GR7487@jirafa.cyrius.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mikael Pettersson <mikpe@it.uu.se> [2010-11-30 13:12]:
> Slightly off-topic, but AFAIK the 6282 is rated for up to 2.0 GHz
> clock speed, while QNap writes that these devices run at 1.6 GHz.
> Do you know if QNap has artificially rate-limited the processors,
> or if they're actually manufactured to only go up to 1.6 GHz?

There are different variants of the 6282, operating at 1.6 GHz, 1.8
GHz and 2.0 GHz.  See
http://www.marvell.com/products/processors/embedded/armada_300/armada_310.pdf

-- 
Martin Michlmayr
http://www.cyrius.com/
