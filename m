From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 16 Mar 2018 15:53:52 +0100
Subject: [PATCH] arm64: dts: armada-3720-espressobin: Document URL for
 schematic
In-Reply-To: <20180316141450.GF17895@lunn.ch>
References: <20180316100124.29972-1-u.kleine-koenig@pengutronix.de>
 <20180316141450.GF17895@lunn.ch>
Message-ID: <20180316145352.n6bqsoxdg5lsol2f@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andrew,

On Fri, Mar 16, 2018 at 03:14:50PM +0100, Andrew Lunn wrote:
> On Fri, Mar 16, 2018 at 11:01:24AM +0100, Uwe Kleine-K?nig wrote:
> > The schematic of hte espressobin is publicly available, add a comment
> > where to find it.
> > 
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> > index bdfb5553ddb5..6d070b267abe 100644
> > --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> > +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> > @@ -42,6 +42,9 @@
> >   *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> >   *     OTHER DEALINGS IN THE SOFTWARE.
> >   */
> > +/*
> > + * Schematic available at http://espressobin.net/wp-content/uploads/2017/08/ESPRESSObin_V5_Schematics.pdf
> > + */
> 
> Version 4 is also available:
> http://wiki.espressobin.net/tiki-download_file.php?fileId=90. I've no
> idea how you tell the boards apart. But my espressobin has more
> jumpers behind the reset button than the board on the home page.

on the back side my board has printed:

	ESPRESSObin_V5_0_1

between the ethernet ports and the blue USB port, so I guess V5 is the
right schematic for me. And my board has 3 3-pin-headers near the reset
button, these are described on page 7 of the V5 schematic.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
