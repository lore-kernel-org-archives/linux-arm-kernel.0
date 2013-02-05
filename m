From: olof@lixom.net (Olof Johansson)
Date: Tue, 5 Feb 2013 11:15:31 -0800
Subject: [GIT PULL] i.MX clock fixes for v3.8
In-Reply-To: <20130205132759.GA17833@n2100.arm.linux.org.uk>
References: <20130205095844.GZ1906@pengutronix.de>
 <20130205110804.GI17786@n2100.arm.linux.org.uk>
 <20130205112558.GA1906@pengutronix.de>
 <201302051312.11434.arnd@arndb.de>
 <20130205132759.GA17833@n2100.arm.linux.org.uk>
Message-ID: <CAOesGMimVynmZeBnLdQa8r2J1B8fM8zvcuhZ9MxxK2Fx95oCpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 5, 2013 at 5:27 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> There's more patches like that post-rc6: there's one
> which fixes an obscure problem with 'make' which occurs with 2G:2G VM
> split.  But I'm not pushing that one either because it's not a _big_
> enough problem (it's only had _one_ user report it.)  One user is not
> sufficient justification.

Can you please make sure that one is marked for stable though? We're
running Chrome OS in 2:2 on ARM, and we're likely going to move to 3.8
at some point.


-Olof
