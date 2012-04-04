From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 4 Apr 2012 07:45:28 +0000
Subject: [PATCH] pinctrl: Add SPEAr pinctrl drivers
In-Reply-To: <CACRpkdZYccTvHEMa=4=-uoLZYQxEPS+932UPA7MGc+-94eLc6w@mail.gmail.com>
References: <a1b7f612544a09989cec80a0318f35b6e48eb1d3.1333453148.git.viresh.kumar@st.com>
 <201204031347.35256.arnd@arndb.de>
 <CACRpkdZYccTvHEMa=4=-uoLZYQxEPS+932UPA7MGc+-94eLc6w@mail.gmail.com>
Message-ID: <201204040745.29187.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 April 2012, Linus Walleij wrote:
> Shall we go in and patch not just pinctrl but also regulator,
> clk etc to return this if the subsystem is not yet up and no maps
> and drivers at all have been yet been registered?

Regulators already do it, IIRC, but a patch for clk and other things
you notice would be nice.

	Arnd
