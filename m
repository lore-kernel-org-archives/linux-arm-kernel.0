From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Mar 2010 10:23:01 +0000
Subject: [PATCH] removing compilation warning comming from <asm/irq.h>
In-Reply-To: <1269598410-15888-1-git-send-email-viresh.kumar@st.com>
References: <1269598410-15888-1-git-send-email-viresh.kumar@st.com>
Message-ID: <20100326102301.GA9126@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 26, 2010 at 03:43:30PM +0530, Viresh KUMAR wrote:
> irq.h is using struct pt_regs *. Due to this compilation
> warning is comming. Removing this warning by adding declaration
> of struct pt_regs.

That's badly placed.  Please re-read the file and place it in a more
appropriate location.
