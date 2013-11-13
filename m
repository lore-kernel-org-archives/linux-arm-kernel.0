From: balbi@ti.com (Felipe Balbi)
Date: Wed, 13 Nov 2013 06:44:23 -0600
Subject: [PATCH] ARM: dts: AM437x GP EVM support
In-Reply-To: <5283247D.7010106@ti.com>
References: <1384255468-2453-1-git-send-email-afzal@ti.com>
 <20131112142206.GD31721@saruman.home> <5283247D.7010106@ti.com>
Message-ID: <20131113124423.GA28192@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 13, 2013 at 12:34:29PM +0530, Afzal Mohammed wrote:
> Hi Felipe,
> 
> On Tuesday 12 November 2013 07:52 PM, Felipe Balbi wrote:
> > On Tue, Nov 12, 2013 at 04:54:26PM +0530, Afzal Mohammed wrote:
> >> From: Lokesh Vutla <lokeshvutla@ti.com>
> 
> >> AM437x GP EVM DTS with pinmux information to make I2C on EVM usable.
> >>
> >> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> >> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> >> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> 
> > could you instead send the much more complete version we already have
> > at [1] ? It's pointless to repatch all of that in this file if we *know*
> > those are already working.
> 
> By taking those changes and testing on mainline, I couldn't get mmc
> working and was not confident about ethernet changes, I2C changes were
> verified and boot test was done (with DT clock series). I posted only
> the changes that I felt confident.
> 
> Basic DT file and I2C are dependency for others, it was necessary to
> remove dependencies at the earliest.

fair enough, still sounds weird not to send the full DTS considering
it won't cause regressions, it just exposes an existing failure WRT
AM437x support upstream.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131113/79ea9155/attachment-0001.sig>
