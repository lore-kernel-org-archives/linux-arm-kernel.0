From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 17:33:32 +0100
Subject: [PATCH 00/10] ARM: s3c64xx multiplatform
In-Reply-To: <20151125163114.GV1929@sirena.org.uk>
References: <1448467615-447097-1-git-send-email-arnd@arndb.de>
 <20151125163114.GV1929@sirena.org.uk>
Message-ID: <61393304.ojuUBpDrS2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 November 2015 16:31:14 Mark Brown wrote:
> On Wed, Nov 25, 2015 at 05:06:45PM +0100, Arnd Bergmann wrote:
> > I've posted the series before and we got a few people to test it
> > the last time, though I think the touchscreen portion is still
> > untested.
> > 
> > I'd really like to get this merged for 4.5 and would put it into
> > a next/multiplatform branch unless there are any objections
> > or concerns.
> 
> Is this a series with interdependencies or just a set of separate fixes?
> 

Patch 9/10 depends on the first eight patches, the last one depends on
that.

	Arnd
