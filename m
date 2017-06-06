From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 6 Jun 2017 16:20:14 +0200
Subject: [PATCH v4 10/10] staging: fsl-mc: move bus driver out of staging
In-Reply-To: <VI1PR0401MB1856DBA58830206CC7DFC18DECCB0@VI1PR0401MB1856.eurprd04.prod.outlook.com>
References: <20170531105852.22304-1-laurentiu.tudor@nxp.com>
 <20170531105852.22304-11-laurentiu.tudor@nxp.com>
 <20170603084027.GA10784@kroah.com>
 <VI1PR0401MB1856DBA58830206CC7DFC18DECCB0@VI1PR0401MB1856.eurprd04.prod.outlook.com>
Message-ID: <20170606142014.GA19404@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 06, 2017 at 02:03:44PM +0000, Laurentiu Tudor wrote:
> Hi Greg, 
> 
> > -----Original Message-----
> > From: Greg KH [mailto:gregkh at linuxfoundation.org]
> > Sent: Saturday, June 03, 2017 11:40 AM
> > 
> > On Wed, May 31, 2017 at 01:58:52PM +0300, laurentiu.tudor at nxp.com wrote:
> > > From: Stuart Yoder <stuart.yoder@nxp.com>
> > 
> > Your subject says 'v4' yet the other patches here in the series do not, they say
> > nothing, or 'v2', and the 0/10 patch says 'v6'!
> 
> I'm tracking the patch versions individually and use the cover letter version (v6 currently)
> to reflect the version of the patch series as a whole. There are a bunch of patches that are either newly
> introduced in this series or didn't had multiple versions so I didn't tagged them with a version tag.
> The patch [10/10] didn't changed since v4 so I left the version unchanged. The only change was in patch [07/10]
> for which I added a commit message so I bumped the version to v2.

And that's totally crazy.  What do you expect me, or anyone else, to
know what to do with that.  Heck, I can't even sort them by proper order
in which to apply them in, if I wanted to.  You are keeping me from
actually using your work :(

> > Please fix up and do this correctly.  The _whole_ patch series is versioned,
> > otherwise how can I sort them to apply them in the correct order?
> 
> Want me to tag all the patches with the same version (that is, v7 for
> the next respin)?

Yes, like everyone else does please :)

thanks,

greg k-h
