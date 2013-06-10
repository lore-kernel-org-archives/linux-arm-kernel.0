From: broonie@kernel.org (Mark Brown)
Date: Mon, 10 Jun 2013 10:06:49 +0100
Subject: [RFC PATCH 28/50] ASoC: atmel-ssc: prepare clk before calling
 enable
In-Reply-To: <51B23B04.20604@overkiz.com>
References: <1370615115-16979-1-git-send-email-b.brezillon@overkiz.com>
 <1370622370-19614-1-git-send-email-b.brezillon@overkiz.com>
 <20130607165510.GA31367@sirena.org.uk> <51B23B04.20604@overkiz.com>
Message-ID: <20130610090649.GC31367@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 07, 2013 at 09:56:52PM +0200, Boris BREZILLON wrote:
> On 07/06/2013 18:55, Mark Brown wrote:
> >On Fri, Jun 07, 2013 at 06:26:09PM +0200, Boris BREZILLON wrote:
> >>Replace clk_enable/disable with clk_prepare_enable/disable_unprepare to
> >>avoid common clk framework warnings.

> >Applied since I happened to notice this on he list but you should
> >*always* CC maintainers on patches otherwise they're likely to get
> >missed.

> I used get_mainainer script and it returns:

> Arnd Bergmann <arnd@arndb.de> (supporter:CHAR and MISC DRI...)
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:CHAR and
> MISC DRI...)
> linux-kernel at vger.kernel.org (open list)

> Please tell me if misuse this script or if I should use something else.

I suspect you only ran this on some of the patches as that's missing
pretty much all of the subsystem maintainers, but in general you always
have to think about the output of get_maintainer.pl - it isn't terribly
reliable.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130610/4298c9b7/attachment.sig>
