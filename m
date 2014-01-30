From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 30 Jan 2014 21:25:00 +0100
Subject: [PATCH v2 00/21] pinctrl: mvebu: restructure and remove
 hardcoded addresses from Dove pinctrl
In-Reply-To: <52EA9EFA.1030609@gmail.com>
References: <1390674856-4993-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1390869573-27624-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140130182925.GM10864@lunn.ch> <52EA9EFA.1030609@gmail.com>
Message-ID: <20140130202500.GN10864@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 30, 2014 at 07:50:34PM +0100, Sebastian Hesselbarth wrote:
> On 01/30/2014 07:29 PM, Andrew Lunn wrote:
> >On Tue, Jan 28, 2014 at 01:39:12AM +0100, Sebastian Hesselbarth wrote:
> >>This patch set is one required step for Dove to hop into mach-mvebu.
> >>Until now, pinctrl-dove was hardcoding some registers that do not
> >>directly belong to MPP core registers. This is not compatible with
> >>what we want for mach-mvebu.
> >
> >I think there might be something wrong here....
> 
> There _is_ something wrong. I'll have a look at it. For the record,
> what SoC are you testing with? From the base address, I guess it is
> Kirkwood?

Yes, Kirkwood. Sorry for not saying.

     Andrew
