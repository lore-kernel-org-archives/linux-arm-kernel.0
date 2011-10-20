From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 20 Oct 2011 15:46:42 +0100
Subject: Update: ARM Sub-Architecture Maintainers workshop at Kernel
	Summit 2011
In-Reply-To: <CAGsJ_4z+DWSXyn6gN9tOAqY3txM22Hk9jNZFPQ_TuYxT3RsRog@mail.gmail.com>
References: <CACxGe6vMLeHrN7jLB2=JYQON1ykOiWTeGiH8YXkUbguV0D-HEw@mail.gmail.com>
	<CACRpkdawG9aKAT7PHuYapiHexkteq-_seQGd6iRORyt-LwbmxA@mail.gmail.com>
	<4EA026C5.1050803@cam.ac.uk>
	<CAGsJ_4z+DWSXyn6gN9tOAqY3txM22Hk9jNZFPQ_TuYxT3RsRog@mail.gmail.com>
Message-ID: <20111020144641.GC6100@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2011 at 10:25:15PM +0800, Barry Song wrote:

> as Jonathan knows, i was one of main authors of those drivers in
> drivers/staging/iio. one problem for iio is now most people still
> write sensor drivers based on input subsystem or others but not iio.
> and Android HAL or other frameworks prefer input _event as well.
> so to push iio ahead, we might push related app ahead too.

Well, that's not entirely clear - one of the reasons for discussing an
in kernel API is so that drivers for these subsystems can make use of
IIO channels.  Another big blocker for deployment of IIO right now is
that it's in staging, fixing that will probably help enormously.
