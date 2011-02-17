From: viresh.kumar@st.com (viresh kumar)
Date: Thu, 17 Feb 2011 09:49:47 +0530
Subject: [PATCH V5 12/63] ST SPEAr: Adding support for CLCD on	SPEAr3xx/6xx
In-Reply-To: <20110216101426.GC6504@n2100.arm.linux.org.uk>
References: <cover.1295499392.git.viresh.kumar@st.com>
	<9a376f8d8a927e333a36a04e9e40e801dbfe398f.1295499394.git.viresh.kumar@st.com>
	<20110216095615.GA6504@n2100.arm.linux.org.uk>
	<20110216101426.GC6504@n2100.arm.linux.org.uk>
Message-ID: <4D5CA1E3.6080604@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/16/2011 03:44 PM, Russell King - ARM Linux wrote:
>> > This choice stuff has gone with the removal of the lpd code from the
>> > kernel, and thus is unmergable.  This kind of platform specific
>> > configuration has no business being in this file anyway.
> The other thing is that the handling of BGR/RGB has changed in the
> 'versatile' branch too, so you may want to delay this patch until
> later.

Ok.

--
viresh
