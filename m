From: mikpe@it.uu.se (Mikael Pettersson)
Date: Tue, 30 Nov 2010 13:12:47 +0100
Subject: [PATCH] Kirkwood: Add support for 6282 based QNAP devices
In-Reply-To: <20101129174440.GA14799@jirafa.cyrius.com>
References: <20101129174440.GA14799@jirafa.cyrius.com>
Message-ID: <19700.59967.284644.290002@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Michlmayr writes:
 > Add support for the QNAP NAS devices based on Marvell's 6282 Kirkwood
 > chip (TS-119P+, TS-219P+ and TS-419P+).  The differences to the 6281
 > based devices are:
 >  - Ethernet PHY address
 >  - GPIOs used for buttons (TS-119P+/TS-219P+)
 > 
 > Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

Slightly off-topic, but AFAIK the 6282 is rated for up to 2.0 GHz
clock speed, while QNap writes that these devices run at 1.6 GHz.
Do you know if QNap has artificially rate-limited the processors,
or if they're actually manufactured to only go up to 1.6 GHz?

/Mikael
