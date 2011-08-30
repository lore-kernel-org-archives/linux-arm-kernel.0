From: balbi@ti.com (Felipe Balbi)
Date: Tue, 30 Aug 2011 12:27:24 +0300
Subject: How to handle named resources with DT?
In-Reply-To: <20110830022912.GE4254@yookeroo.fritz.box>
References: <20110809205723.GE11568@ponder.secretlab.ca>
	<877h6173wm.fsf@ti.com> <20110826041200.GD2308@yookeroo.fritz.box>
	<201108261258.32880.arnd@arndb.de> <4E57A9FB.5030404@ti.com>
	<20110830022912.GE4254@yookeroo.fritz.box>
Message-ID: <20110830092722.GG23907@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 30, 2011 at 12:29:12PM +1000, David Gibson wrote:
> So, I actually agree that in the long term getting resource names in
> the DT would be a generally good thing.
> 
> But doing so is a *huge* change in one of the very core semantics of
> all the DT bindings.  It's not something that should be done lightly
> or quickly.  It absolutely should not be tied to how this is handled

the longer you take to change, the more complex will it be to change.
The longer we spend discussing the validity of _byname(), more
boards/archs/whatnot will be converted to DT without _byname() and after
a certain amount of them are converted, noone will be willing to change
and validate everything again.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110830/7f00a399/attachment.sig>
