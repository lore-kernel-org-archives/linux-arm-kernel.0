From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 27 Mar 2010 21:42:58 +0000
Subject: [PATCH] removing compilation warning comming from clkdev.h
In-Reply-To: <1269511413-30621-2-git-send-email-viresh.kumar@st.com>
References: <1269511413-30621-1-git-send-email-viresh.kumar@st.com>
	<1269511413-30621-2-git-send-email-viresh.kumar@st.com>
Message-ID: <20100327214258.GB13203@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 25, 2010 at 03:33:33PM +0530, Viresh KUMAR wrote:
> clkdev.h is using struct device *. Due to this compilation
> warning is comming. Removing this warning.

Ok.
