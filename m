From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 May 2015 10:01:05 +0100
Subject: [PATCH v3 2/2] arch: arm: Show the serial number from devicetree
 in cpuinfo
In-Reply-To: <1430581582.5339.0.camel@collins>
References: <1429351135-11842-1-git-send-email-contact@paulk.fr>
 <1429351135-11842-2-git-send-email-contact@paulk.fr>
 <CAL_JsqKkw7n5p1ZH345BeKkyU=GKDrhaLef__0ET7t90Cm0Eog@mail.gmail.com>
 <1430145747.3081.5.camel@collins>
 <20150428160910.GE12732@n2100.arm.linux.org.uk>
 <1430581582.5339.0.camel@collins>
Message-ID: <20150506090105.GC2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 02, 2015 at 05:46:22PM +0200, Paul Kocialkowski wrote:
> Le mardi 28 avril 2015 ? 17:09 +0100, Russell King - ARM Linux a ?crit :
> > On Mon, Apr 27, 2015 at 04:42:27PM +0200, Paul Kocialkowski wrote:
> > > Well, of_property_read_string is only defined when CONFIG_OF is set
> > > (base.c is always built in drivers/of but the directory is only included
> > > when CONFIG_OF is set).
> > > 
> > > Of course, on ARM, we now expect that it is the case, but it seems like
> > > good practice to check for it, since it could theoretically be disabled.
> > 
> > That is _not_ "is the case" - there are a number of non-OF platforms...
> > including some which will probably never be converted.
> 
> Right, so I think v4 should be fine too, given the empty functions in
> case CONFIG_OF is not set.

Yes, can you please put them in my patch system so we can get this
applied?

Rob - does your ack apply to the v4 patch?

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
