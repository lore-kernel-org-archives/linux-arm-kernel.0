From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Apr 2010 20:44:20 +0100
Subject: [PATCH resend] removing compilation warning comming from
	<asm/irq.h>
In-Reply-To: <1269599968-32459-1-git-send-email-viresh.kumar@st.com>
References: <1269599968-32459-1-git-send-email-viresh.kumar@st.com>
Message-ID: <20100412194420.GR3048@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 26, 2010 at 04:09:28PM +0530, Viresh KUMAR wrote:
> irq.h is using struct pt_regs *. Due to this compilation
> warning is comming. Removing this warning by adding declaration
> of struct pt_regs.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Much better, thanks.
