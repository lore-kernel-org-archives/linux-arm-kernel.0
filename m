From: viresh.kumar@st.com (viresh kumar)
Date: Mon, 1 Aug 2011 16:04:35 +0530
Subject: [PATCH V2 03/20] dmaengine/amba-pl08x: Rearrange inclusion of
	header files in ascending order
In-Reply-To: <4E367776.1070008@ru.mvista.com>
References: <cover.1312190881.git.viresh.kumar@st.com>
	<16f5abd9452832860f3a11fe1ddabde05fa3ae8c.1312190881.git.viresh.kumar@st.com>
	<4E367776.1070008@ru.mvista.com>
Message-ID: <4E36813B.7090509@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/2011 03:22 PM, Sergei Shtylyov wrote:
>> > +#include<linux/slab.h>
>     Shouldn't there be emoty line here?
> 
>> >   #include<asm/hardware/pl080.h>


Ya, can be, but i thought it is also fine. Don't know.
If you want i can do that.

-- 
viresh
