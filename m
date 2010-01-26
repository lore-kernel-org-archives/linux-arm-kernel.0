From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 26 Jan 2010 11:09:45 +0000
Subject: [PATCH 2/3] ASoC: AC97: S3C: Add controller driver
In-Reply-To: <1b68c6791001260303m38e6e689p2ee8c2c4c6ac2af3@mail.gmail.com>
References: <1264485101-13782-1-git-send-email-jassisinghbrar@gmail.com>
	<1264485101-13782-2-git-send-email-jassisinghbrar@gmail.com>
	<20100126102343.GA24843@trinity.fluff.org>
	<1b68c6791001260303m38e6e689p2ee8c2c4c6ac2af3@mail.gmail.com>
Message-ID: <20100126110945.GJ15759@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2010 at 08:03:09PM +0900, jassi brar wrote:

> The only reason I didn't submit patch to delete s3c2443-ac97.c is that my
>  smdk2443 didn't produce any sound. (btw the s3c2443-ac97.c also fails to do so)

If they both work equally well please just go ahead and remove the old
driver.  Keeping the old driver around if it doesn't work is likely to
result in any fixups going into that.
