From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 09 Sep 2016 17:59:24 +0200
Subject: [RESEND GIT PULL] STi DT fixes for v4.8-rcs
In-Reply-To: <f2d83529-3ab1-fe8e-c599-cf5dfbb1f17b@st.com>
References: <f2d83529-3ab1-fe8e-c599-cf5dfbb1f17b@st.com>
Message-ID: <4661882.KbqgLxDlJz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 8, 2016 5:21:00 PM CEST Patrice Chotard wrote:
> Handle STiH410 interconnect clock required for EHCI/OHCI and SDHCI
> 
> With the introduction of critical-clock support in v4.8, our developers'
> default configuration is to run with 'clk_ignore_unused' removed.  This
> patch-set ensures they can achieve successful boot when a) booting from
> an SD Card and when b) booting using USB->Eth adaptors for NFS booting.
> 
> 

Pulled into fixes, thanks!

	Arnd
