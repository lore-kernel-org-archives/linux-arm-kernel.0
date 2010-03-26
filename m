From: viresh.kumar@st.com (Viresh KUMAR)
Date: Fri, 26 Mar 2010 16:03:42 +0530
Subject: [PATCH] removing compilation warning comming from <asm/irq.h>
In-Reply-To: <20100326102301.GA9126@n2100.arm.linux.org.uk>
References: <1269598410-15888-1-git-send-email-viresh.kumar@st.com>
	<20100326102301.GA9126@n2100.arm.linux.org.uk>
Message-ID: <4BAC8D86.2070709@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/26/2010 3:53 PM, Russell King - ARM Linux wrote:
> On Fri, Mar 26, 2010 at 03:43:30PM +0530, Viresh KUMAR wrote:
>> irq.h is using struct pt_regs *. Due to this compilation
>> warning is comming. Removing this warning by adding declaration
>> of struct pt_regs.
> 
> That's badly placed.  Please re-read the file and place it in a more
> appropriate location.
> 

OK.
