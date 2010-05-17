From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 17 May 2010 16:51:39 +0530
Subject: [PATCH Resend] Watchdog: Adding support for Watchdog found	with
	ARM CortexA9
In-Reply-To: <20100517111555.GB29422@n2100.arm.linux.org.uk>
References: <1274090321-14665-1-git-send-email-viresh.kumar@st.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C558B841@dbde02.ent.ti.com>
	<4BF11B51.7000808@st.com>
	<20100517111555.GB29422@n2100.arm.linux.org.uk>
Message-ID: <4BF126C3.9090708@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/17/2010 4:45 PM, Russell King - ARM Linux wrote:
> On Mon, May 17, 2010 at 04:02:49PM +0530, Viresh KUMAR wrote:
>> On 5/17/2010 3:49 PM, Shilimkar, Santosh wrote:
>>> What is the ARM_AMBA dependency with CA-9 watchdog?
>>
>> Not really on amba, rather on ARM. Or CPU_V7 (cortex related)?
>> Maybe some other ARM core also have similar design,
>> so can keep it dependent on ARM. Does this looks fine?
> 
> It makes sense to make it dependent on CPU_V7 for the time being.
> 

OK.
