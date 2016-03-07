From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 7 Mar 2016 10:29:28 +0700
Subject: [GIT PULL 1/4] ARM: imx: soc updates for 4.6
In-Reply-To: <2391647.boUdyk2pYU@wuerfel>
References: <1456844403-26176-1-git-send-email-shawnguo@kernel.org>
 <2391647.boUdyk2pYU@wuerfel>
Message-ID: <20160307032927.GA5051@x250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 02, 2016 at 11:32:00PM +0100, Arnd Bergmann wrote:
> On Tuesday 01 March 2016 23:00:00 Shawn Guo wrote:
> > The i.MX SoC update for 4.6:
> > - Enable big endian mode support for i.MX platform
> > - Add support for i.MX6QP SoC which is the latest i.MX6 family addition
> > - Add basic suspend/resume support for i.MX25
> > - A couple of i.MX7D support updates
> 
> 
> Merged into next/soc, thanks!
> 
> 
> > - A few random code cleanups
> 
> I wonder if those should have been in a separate cleanup branch. I didn't
> look at the detailed changes here, so I assume you had a good reason
> to put them in here.

I generally only create a cleanup branch for some significant changes,
which usually consists of a series or quite some patches.  If you want
to see a cleanup branch for small changes, I can do that too.

Shawn
