From: jassisinghbrar@gmail.com (jassi brar)
Date: Tue, 26 Jan 2010 20:57:56 +0900
Subject: [PATCH 2/3] ASoC: AC97: S3C: Add controller driver
In-Reply-To: <20100126110945.GJ15759@rakim.wolfsonmicro.main>
References: <1264485101-13782-1-git-send-email-jassisinghbrar@gmail.com>
	<1264485101-13782-2-git-send-email-jassisinghbrar@gmail.com>
	<20100126102343.GA24843@trinity.fluff.org>
	<1b68c6791001260303m38e6e689p2ee8c2c4c6ac2af3@mail.gmail.com>
	<20100126110945.GJ15759@rakim.wolfsonmicro.main>
Message-ID: <1b68c6791001260357p62b5c10dpfa2a5ddcae0704dd@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2010 at 8:09 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Jan 26, 2010 at 08:03:09PM +0900, jassi brar wrote:
>
>> The only reason I didn't submit patch to delete s3c2443-ac97.c is that my
>> ?smdk2443 didn't produce any sound. (btw the s3c2443-ac97.c also fails to do so)
>
> If they both work equally well please just go ahead and remove the old
> driver. ?Keeping the old driver around if it doesn't work is likely to
> result in any fixups going into that.
ok, will submit a patch for that too.
Btw, I don't have ln2440sbc and don't know how would it take the change,
though I sincerely think it should be just fine.
