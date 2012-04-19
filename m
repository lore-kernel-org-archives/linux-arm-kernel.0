From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Apr 2012 08:57:19 +0000
Subject: [PATCH 00/13] SPEAr: Move to common clock framework
In-Reply-To: <CAJOA=zO4E0YJ0OU9n-abbNd+0VXQGsFi5Tnu5y=riHSgqk=xMw@mail.gmail.com>
References: <cover.1334660431.git.viresh.kumar@st.com>
 <CAJOA=zNPKrSSL5wjNBwL9qie5sGv9j=k3rSAmsjbK-6jfJwbgQ@mail.gmail.com>
 <CAJOA=zO4E0YJ0OU9n-abbNd+0VXQGsFi5Tnu5y=riHSgqk=xMw@mail.gmail.com>
Message-ID: <201204190857.19770.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 April 2012, Turquette, Mike wrote:
> I've taken patches 02 - 06 into my -next branch.  Patch 01 isn't for
> me really, and I've not yet tested patch 07 (I'll take it everything
> looks good).  The rest of your series (08 - 13) should probably go
> through Arnd.

My preference would be to have the whole series go through your tree
and move the implementation of the spear clock code to drivers/clk
in the process. This will reduce interdependencies between the spear
clock branch and other branches that have spear patches.

I also think it's a good idea if you submit the clk patches to Linus
directly for the next merge window, but it's ok to use arm-soc if
that makes you feel more confident about it.

	Arnd
