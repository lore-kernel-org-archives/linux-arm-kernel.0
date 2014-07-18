From: heiko.stuebner@bq.com (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 18 Jul 2014 12:47:53 +0200
Subject: [PATCH v10 5/7] arm: add basic support for Mediatek MT6589 boards
In-Reply-To: <53C8ED0B.5080802@linaro.org>
References: <1404745988-32558-1-git-send-email-matthias.bgg@gmail.com>
 <1404745988-32558-6-git-send-email-matthias.bgg@gmail.com>
 <53C8ED0B.5080802@linaro.org>
Message-ID: <127793649.dTvqVjg5LM@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

Am Freitag, 18. Juli 2014, 11:46:51 schrieb Daniel Lezcano:
> On 07/07/2014 05:13 PM, Matthias Brugger wrote:
> > This adds a generic devicetree board file and a dtsi for boards
> > based on MT6589 SoCs from Mediatek.
> > 
> > Apart from the generic parts (gic, clocks) the only component
> > currently supported are the timers.
> > 
> > Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> > --
> 
> I will take this patchset through my tree but this patch touches an area
> I am not handling.
> 
> Olof, Arnd, do you mind to ack this patch ?

wouldn't it be easier to just take patches 1,2,3,4 through your tree and let 
patches 5,6,7 go through arm-soc?

There is no compile-time dependency between the two parts, so they will come 
together nicely in linux-next and during the merge-window.


Also in [0] Olof wrote:

----------
Traditionally we usually take the DT changes through arm-soc, but as
long as we share the branch we might be ok. We tend to stick them in
different branches in our tree though, so rockchip will be a little
mis-sorted this release. Not a big deal, and we can deal with it.
-----------

So I'd assume splitting the patchset this way might be a nice solution?


Heiko


[0] http://www.spinics.net/lists/arm-kernel/msg347053.html
