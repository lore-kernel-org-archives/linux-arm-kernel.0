From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 14 Apr 2014 14:06:48 +0200
Subject: [PATCH 20/29] ARM: orion5x: convert edmini_v2 to DT pinctrl
In-Reply-To: <534BC62D.6010000@gmail.com>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397400006-4315-21-git-send-email-thomas.petazzoni@free-electrons.com>
 <534BBDAC.2010801@gmail.com> <20140414132329.48df793e@skate>
 <534BC62D.6010000@gmail.com>
Message-ID: <20140414120648.GB20845@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 14, 2014 at 01:27:41PM +0200, Sebastian Hesselbarth wrote:
> On 04/14/2014 01:23 PM, Thomas Petazzoni wrote:
> >Dear Sebastian Hesselbarth,
> >
> >On Mon, 14 Apr 2014 12:51:24 +0200, Sebastian Hesselbarth wrote:
> >
> >>>   		internal-regs {
> >>>+			pinctrl at 10000 {
> >>
> >>Use node label reference:
> >>
> >>&pinctrl {
> >>	...
> >>};
> >
> >I personally dislike using node label references. I know they are used
> >for Ethernet because it has been done by someone else for Orion
> >platforms. But on all Armada 370/XP platforms, we don't use node label
> >references, and I'd prefer to do it the same way for Orion5x platforms
> >if possible.
> 
> Well, I definitely disagree and would like to _enforce_ using node
> label references. Anyway, if there is a strong reason for not using
> them, I'd be fine too.
 
Hi Sebastian, Thomas

Could you both explain your like/dislike for using node labels.

Thanks
	Andrew
