From: johan@kernel.org (Johan Hovold)
Date: Wed, 29 Oct 2014 14:00:50 +0100
Subject: [PATCH v2 00/20] rtc: omap: fixes and power-off feature
In-Reply-To: <CABgxDo+ewxNwb3RrBVZA7kqYMvSujLb9U6A6FCvnHQH1W8V0kg@mail.gmail.com>
References: <20141024194442.GG11455@saruman> <20141024195532.GF19377@localhost>
 <20141027162251.d7ff2a5f31917c638d4e47f7@linux-foundation.org>
 <20141028002552.GX12379@n2100.arm.linux.org.uk>
 <20141028081616.GL2006@localhost>
 <20141028084745.GY12379@n2100.arm.linux.org.uk>
 <20141028131257.GS2006@localhost>
 <20141028151610.GA12379@n2100.arm.linux.org.uk>
 <20141029123418.GB2265@localhost>
 <CABgxDo+ewxNwb3RrBVZA7kqYMvSujLb9U6A6FCvnHQH1W8V0kg@mail.gmail.com>
Message-ID: <20141029130050.GC2265@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ Please do not top-post. ]

On Wed, Oct 29, 2014 at 01:55:49PM +0100, Romain Perier wrote:
> Johan:. do you really plan to use this "poweroff-source" property ? As
> you proposed a renaming few days ago...
> I don't really want to waste time to propose patches to fix things
> incrementally and rename it if the old one is used...

Why would I want to use your retracted renaming proposal for this
property (i.e. "poweroff-source")?

These patches use "ti,system-power-controller" and the vendor prefix
will be dropped when your patches have been merged.

Johan
