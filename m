From: ijc@debian.org (Ian Campbell)
Date: Tue, 12 May 2015 10:11:29 +0100
Subject: Bug#782364: linux-image-3.16.0-4-armmp: please configure
 drivers for both Cubox i4pro real time clocks
In-Reply-To: <47E9FE80-96C8-4D91-B161-53A61A8A5FCB@pobox.com>
References: <20150410232854.23367.58862.reportbug@cube.rcthomas.org>
 <1428710930.29665.17.camel@decadent.org.uk>
 <20150429085705.GG12732@n2100.arm.linux.org.uk>
 <1430582464.15640.186.camel@hellion.org.uk>
 <20150502161226.GS12732@n2100.arm.linux.org.uk>
 <1430583695.15640.190.camel@hellion.org.uk>
 <1430899272.15640.237.camel@debian.org>
 <64A51823-C50B-48D5-8180-CBC44F691CCB@pobox.com>
 <1430908023.2660.203.camel@debian.org>
 <1250B1D0-EBAA-404C-B0F2-686DE9E4D156@pobox.com>
 <47E9FE80-96C8-4D91-B161-53A61A8A5FCB@pobox.com>
Message-ID: <1431421889.8263.97.camel@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-05-12 at 01:33 -0700, Rick Thomas wrote:
> On May 6, 2015, at 3:35 AM, Rick Thomas <rbthomas@pobox.com> wrote:
> 
> > 
> > On May 6, 2015, at 3:27 AM, Ian Campbell <ijc@debian.org> wrote:
> > 
> >> It would be preferable to test the thing in Sid before the upload to
> >> jessie-proposed-updates
> > 
> > I?ll keep an eye out for it.
> > 
> > But I don?t have one of the cubox models without the battery-backed
> RTC, so I won?t be able to test that case.   Is there anyone out there
> in debian-arm land with an appropriate test box?
> > 
> > Enjoy!
> > Rick
> 
> Am I looking in the wrong place?  I would have expected to see
> something show up in sid by now.
> 
> Is there a particular linux-image?.deb I should download from
> somewhere to test this?

According to https://tracker.debian.org/pkg/linux it was uploaded
yesterday and according to
https://buildd.debian.org/status/package.php?p=linux the armhf version
has been built and was installed in the archive ~5hrs ago.

It hasn't shown up on the UK mirror yet at least, whereas the binaries
for some arches with faster buildds have.

I expect it'll show up in the next mirror pulse.

Ian.
