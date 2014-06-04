From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 4 Jun 2014 17:50:49 +0200
Subject: [GIT PULL] Allwinner sunXi clock changes for 3.16
In-Reply-To: <20140604151216.10062.81810@quantum>
References: <538B7B6C.3020601@elopez.com.ar>
 <20140603174120.10062.16229@quantum>
 <20140604071922.GA5765@lukather>
 <20140604151216.10062.81810@quantum>
Message-ID: <20140604155049.GD5765@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 04, 2014 at 08:12:16AM -0700, Mike Turquette wrote:
> Quoting Maxime Ripard (2014-06-04 00:19:22)
> > Hi Mike,
> > 
> > On Tue, Jun 03, 2014 at 10:41:20AM -0700, Mike Turquette wrote:
> > > Quoting Emilio L?pez (2014-06-01 12:13:48)
> > > > Hi Mike,
> > > > 
> > > > Here is the sunxi clocks pull for 3.16. As you probably saw during the 
> > > > cycle, this mostly contains improved A31 support and a bit of 
> > > > housekeeping. Please note that this pull does *not* contain the MMC 
> > > > clock patches Hans sent, as you merged those yourself on clk-next
> > > 
> > > Hi Emilio,
> > > 
> > > -rc8 is pretty late for me to take this in under normal circumstances,
> > > and since the merge window opened early this time I will defer taking
> > > this pull request in until 3.16-rc1 is released. It'll be one of the
> > > first things applied to the new clk-next.
> > 
> > I know that Emilio has been pretty late at sending this, but at least
> > the A31 USB clocks patches is quite important for us, since it would
> > allow to add the A31 to Olof's boot test farm.
> 
> I guess you will still reap the benefits of Olof's boot testing if this
> is merged after 3.16-rc1?

Well, yeah, but it would be delayed by a release, while the needed
drivers are already there.

> > Could you reconsider merging this?
> > 
> > Just so that doesn't happen again, when do you expect the pull
> > requests?
> 
> There isn't a hard rule for "must be in by -rcN". But I really don't
> like taking patches after the merge window opens. Something bothers me
> about the commitdate for patches in clk-next being later than the
> commitdate for the new Linux major release.

Which won't happen in this case, since we're at -rc8 ;)

> I always take some trivial patches during this time, or fixes which
> are obvious and would have to be sent for the next round of -rc's
> anyways, but features or new hardware support is something I don't
> like to take after the merge window opens.
> 
> I was bit a couple merge windows back by trying to be too aggressive
> about sneaking stuff in at the last minute and I learned my lesson
> ;-)

If it makes it easier for you, I've been carrying these patches for
quite some time in my working branch.

But I definitely understand.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140604/afed36ae/attachment-0001.sig>
