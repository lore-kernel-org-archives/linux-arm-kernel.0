From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 24 Nov 2015 15:27:31 +0000
Subject: [PATCH 1/4] ARM: dts: kirkwood: add Linksys EA4500
In-Reply-To: <00000150d4adea4a-a422d621-19a4-4bec-a4d8-c4ae170e8113-000000@email.amazonses.com>
References: <00000150d49a7cf7-e97bf540-89ce-49bf-a25e-2d082acab273-000000@email.amazonses.com>
 <3957044.Sz6eC5OsVr@wuerfel>
 <00000150d4adea4a-a422d621-19a4-4bec-a4d8-c4ae170e8113-000000@email.amazonses.com>
Message-ID: <20151124152731.GU6520@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Luka,

On Wed, Nov 04, 2015 at 10:46:19PM +0000, Luka Perkov wrote:
> On Wed, Nov 04, 2015 at 11:41:01PM +0100, Arnd Bergmann wrote:
> > On Wednesday 04 November 2015 22:25:05 Luka Perkov wrote:
> > > +/ {
> > > +	model = "Linksys EA4500";
> > > +	compatible = "linksys,ea4500", "marvell,kirkwood-88f6282", "marvell,kirkwood";
> > 
> > According to https://wikidevi.com/wiki/Linksys_EA4500 there are multiple versions
> > of this device, and at least EA4500v3 is completely incompatible with the version
> > in this patch. Should we add "linksys,ea4500v1" as a compatible string to identify
> > this better?
> 
> Right. I'll send v2 after getting some more comments.

Did I miss the v2?

thx,

Jason.
