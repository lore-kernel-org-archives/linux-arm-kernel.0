From: viresh.kumar@st.com (viresh kumar)
Date: Fri, 14 Jan 2011 14:14:49 +0530
Subject: [PATCH] mm/init.c: fix compilation warning
In-Reply-To: <20110114083524.GK24149@n2100.arm.linux.org.uk>
References: <1294989051-830-1-git-send-email-viresh.kumar@st.com>
	<20110114083524.GK24149@n2100.arm.linux.org.uk>
Message-ID: <4D300D01.9020707@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/14/2011 02:05 PM, Russell King - ARM Linux wrote:
> On Fri, Jan 14, 2011 at 12:40:51PM +0530, Viresh Kumar wrote:
>> This patch fixes following warning:
>> mm/init.c:606: warning: format '%08lx' expects type 'long unsigned int', but
>> argument 12 has type 'unsigned int'
> 
> The problem is in your definition of VMALLOC_END.  It should be typed
> unsigned long - so have a UL suffix on the number.
> 

Ok. Will correct that.
thanks.

-- 
viresh
