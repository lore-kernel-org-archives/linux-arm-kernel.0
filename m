From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 8 Sep 2016 21:46:58 +0200
Subject: [RFC 1/7] Make Hi3620 explicit, remove wildcards
In-Reply-To: <20160908172346.27506-1-netz.kernel@gmail.com>
References: <20160908172346.27506-1-netz.kernel@gmail.com>
Message-ID: <20160908194658.GC11400@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marty

Adding to Jasons comments... a [0/7] "patch" created via --cover
should be include with all multi-patch series. It should explain the
big picture for the whole set. What does this set do. Then you can
leave each patch just explaining what it does.

Some maintainers will use the cover note as the log for the merge
commit. So keep it formal in the same way as the individual patches
comment.

   Andrew
