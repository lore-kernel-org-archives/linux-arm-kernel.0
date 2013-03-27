From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Wed, 27 Mar 2013 03:26:31 +0200
Subject: [PATCH v4 0/6] support other fsl SoCs with usbmisc + small fixes
In-Reply-To: <20130318133000.GA16342@pengutronix.de>
References: <1354033021-10585-1-git-send-email-m.grzeschik@pengutronix.de>
 <20121128025217.GC18593@nchen-desktop>
 <87ip6mor1e.fsf@ashishki-desk.ger.corp.intel.com>
 <20130307225403.GI29785@pengutronix.de>
 <20130318133000.GA16342@pengutronix.de>
Message-ID: <871ub1my48.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael Grzeschik <mgr@pengutronix.de> writes:

> On Thu, Mar 07, 2013 at 11:54:03PM +0100, Michael Grzeschik wrote:
>> Hey Alex,
>> 
>> On Thu, Jan 24, 2013 at 11:42:53AM +0200, Alexander Shishkin wrote:
>> > Peter Chen <peter.chen@freescale.com> writes:
>> > 
>> > > On Tue, Nov 27, 2012 at 05:16:55PM +0100, Michael Grzeschik wrote:
>> > >> Nearly every SoC from Freescale has this non-core usb registers. This series
>> > >> adds support for more users of this driver.
>> > >> 
>> > >> This series is based on Peter Chen's work. Its needed to merge his master branch
>> > >> before applying this series:
>> > >> 
>> > >> https://github.com/hzpeterchen/linux-usb.git
>> > >
>> > > I have tested it at i.mx6q sabrelite board, it works good.
>> > >
>> > > I have pushed your commit to my git, please cc me
>> > > your coming chipidea patches, thanks.
>> > >
>> > > Alex, please add:
>> > >
>> > > Reviewed-by: Peter Chen <peter.chen@freescale.com>
>> > > Tested-by: Peter Chen <peter.chen@freescale.com>
>> > 
>> > Looks good, queueing this one for submission.
>> 
>> Now that you have your git-tree [1], could you queue that for
>> submission?
>> 
>> [1] git://github.com/virtuoso/linux-ci.git ci-for-greg
>
> Ping!

What would have been more helpful here is a resend of these patches
rebased so that they at least apply.

So I had to fix that, fix some warnings here and there (before the
sparse police catches up with you) and otherwise had a good time.

Applied and pushed to ci-for-greg.

Thanks,
--
Alex
