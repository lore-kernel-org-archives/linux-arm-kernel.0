From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Apr 2012 21:30:44 +0000
Subject: [PATCH] ARM: SPEAr3xx: Correct keyboard data passed from DT
In-Reply-To: <1f044de2d6d026b27222690777660e45b98c4b0f.1335246229.git.viresh.kumar@st.com>
References: <1f044de2d6d026b27222690777660e45b98c4b0f.1335246229.git.viresh.kumar@st.com>
Message-ID: <201204302130.44183.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 April 2012, Viresh Kumar wrote:
> keyboard data passed via DT is in wrong format. Fix it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  arch/arm/boot/dts/spear300-evb.dts |  162 ++++++++++++++++++------------------
>  1 files changed, 81 insertions(+), 81 deletions(-)

Applied to spear/dt and next/dt.

	Arnd
