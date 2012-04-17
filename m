From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 17 Apr 2012 22:57:50 +0800
Subject: [PATCH 00/13] SPEAr: Move to common clock framework
In-Reply-To: <201204171434.06178.arnd@arndb.de>
References: <cover.1334660431.git.viresh.kumar@st.com>
 <201204171434.06178.arnd@arndb.de>
Message-ID: <20120417145745.GB6024@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2012 at 02:34:05PM +0000, Arnd Bergmann wrote:
> I wonder: should the clock drivers remain part of the platform directory,
> or get moved into a subdirectory of drivers/clk? I was assuming that 
> we'd do the latter, but I haven't been following the clk discussions
> that closely.
> 
Mike had some comment [1] there, and I would second that.

Regards,
Shawn

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/158320/focus=158543
