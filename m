From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 9 Oct 2015 09:52:04 +0200
Subject: [PATCH v2 3/5] ARM: mvebu: set SW polling as SDHCI card
 detection on A388-GP
In-Reply-To: <1444352635-21965-4-git-send-email-mw@semihalf.com>
References: <1444352635-21965-1-git-send-email-mw@semihalf.com>
 <1444352635-21965-4-git-send-email-mw@semihalf.com>
Message-ID: <20151009095204.41010dd9@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Marcin Wojtas,

On Fri,  9 Oct 2015 03:03:53 +0200, Marcin Wojtas wrote:
> The newest revisions of A388-GP (v1.5 and higher) support only
> DAT3-based card detection. Revisions < v1.5 based on GPIO detection
> via I2C expander, but this solution is supposed to be deprecated on
> new boards. In order to satisfy all type of hardware this commit
> changes card detection to use software polling mechanism.
> 
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>

Can we add a comment on the DT that explains why SW polling is used,
and which other mechanism can be used depending on the board revision?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
