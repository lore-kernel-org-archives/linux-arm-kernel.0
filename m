From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 25 Aug 2012 10:22:31 +0200
Subject: [PATCH 01/11] pinctrl: mvebu: pinctrl driver core
In-Reply-To: <CACRpkda0wUW4E3y=ucGRFu5fwwyFWo2dc=4qBaH6CFSOW2ZL_A@mail.gmail.com>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1344689809-6223-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <CACRpkda0wUW4E3y=ucGRFu5fwwyFWo2dc=4qBaH6CFSOW2ZL_A@mail.gmail.com>
Message-ID: <20120825082231.GG9886@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 20, 2012 at 11:09:51AM +0200, Linus Walleij wrote:
> On Sat, Aug 11, 2012 at 2:56 PM, Sebastian Hesselbarth
> <sebastian.hesselbarth@gmail.com> wrote:
> 
> > This patch adds a pinctrl driver core for Marvell SoCs plus DT
> > binding documentation. This core driver will be used by SoC family
> > specific drivers, i.e. Armada XP, Armada 370, Dove, Kirkwood, aso.
> 
> Thanks for dealing with this, much appreaciated!
> 
> Are you taking this patch series through some Marvell tree or do you want
> me to carry it in the pinctrl tree?

Hi Linus

We can carry it thought the Marvell tree. 

   Andrew
