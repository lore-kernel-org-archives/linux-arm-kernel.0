From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Feb 2014 11:22:51 +0100
Subject: [PATCH v4 00/16] pinctrl: mvebu: restructure resource allocation
In-Reply-To: <20140223154053.GN7862@titan.lakedaemon.net>
References: <1392220776-30851-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1393165274-32492-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140223154053.GN7862@titan.lakedaemon.net>
Message-ID: <CACRpkdZFwcFtZiDH792awhyrQ6wtEsJMMN9K_ypCbqLqZo9LLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 23, 2014 at 4:40 PM, Jason Cooper <jason@lakedaemon.net> wrote:

> I certainly don't want to assume we can take this, and you've been quiet
> on the previous versions of this series.  We have a lot of moving pieces
> for getting the Armada 375/380/385 support added to the kernel.  It's a
> huge help to us if we can create a topic branch for you with the pinctrl
> changes in it.

I understand, sorry I was on a short vacation.

I've applied Thomas' two new SoC drivers and started queueing
Sebastians series but it's a bit messy. Right now I'm not finding
patch 06/21 v4....

>> https://github.com/shesselba/linux-dove.git unstable/mvebu-pinctrl-v3.14_v4

Should I just pull this in instead, as it contains both Thomas' and Sebastians
patches, and then you can send me more stuff on top of that?

Yours,
Linus Walleij
