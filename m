From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Tue, 20 Nov 2012 00:48:07 -0800
Subject: [PATCH v3 1/3] power: Add simple poweroff-gpio driver
In-Reply-To: <20121120083749.GM10259@lunn.ch>
References: <1353142266-1289-1-git-send-email-andrew@lunn.ch>
 <1353142266-1289-2-git-send-email-andrew@lunn.ch>
 <50AA6E7E.5060501@wwwdotorg.org> <20121120083749.GM10259@lunn.ch>
Message-ID: <20121120084807.GA24287@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 09:37:49AM +0100, Andrew Lunn wrote:
> These are good comments from Stephan that i want to address. However,
> i also don't want to delay the pull-requests direction arm-soc, the
> merge window is getting close. Both Linus and Anton have Acked the
> current version, so please go with what you have and i will produce a
> patch over the top. If its available before Arnd pulls, you can squash
> it, otherwise send it upstream as a standalone patch.

I agree. Furthermore, for the fixup patch, if it goes separately, you
might want to add

 Suggested-by: Stephen Warren <swarren@wwwdotorg.org>

to give a credit for the valuable comments. :)
