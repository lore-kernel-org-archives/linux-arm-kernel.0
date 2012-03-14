From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 14 Mar 2012 11:28:20 +0000
Subject: [PATCH v4 02/11] ep93xx: Don't use system controller defines in
 audio drivers
In-Reply-To: <4F5FF1DD.5020003@gmail.com>
References: <1331592502-9083-3-git-send-email-rmallon@gmail.com>
 <201203131209.52031.arnd@arndb.de> <4F5FF1DD.5020003@gmail.com>
Message-ID: <20120314112820.GA3133@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2012 at 12:18:21PM +1100, Ryan Mallon wrote:

> Okay, the patches still need to be posted as a series for review before
> doing a pull request though right? Should I just put a note on such
> patches (below the changelog) that I am expecting to send them all via
> arm-soc so that other maintainers don't grab individual patches for
> driver support?

You should always say if there's some dependency.  With things like this
it's possibly easier to leave the defines hanging around for a while and
then send a followup patch which removes them, that way there's no
dependencies.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120314/9fc3e756/attachment.sig>
