From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 19 Jun 2012 21:35:31 +0200
Subject: Dove clock support
In-Reply-To: <4FE0D37F.1020300@googlemail.com>
References: <20120618080449.GK4799@lunn.ch> <4FDEE6C6.2060101@blackshift.org>
 <20120618084300.GL4799@lunn.ch> <4FDEF7E9.4030504@googlemail.com>
 <4FDEFAE2.7000303@blackshift.org> <4FDEFC6A.7030300@googlemail.com>
 <20120618101100.GN4799@lunn.ch> <4FDF91D1.1040301@googlemail.com>
 <20120619192518.GQ26034@lunn.ch> <4FE0D37F.1020300@googlemail.com>
Message-ID: <20120619193531.GS26034@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Of course, this renaming can be postponed after the gory details of DT
> have been finished. But yes, it would be nice and a lot of work.

Actually, i would suggest doing it before DT is complete,
i.e. ASAP. At the moment there are very few auxdata entries, meaning
there is less to change.

      Andrew
