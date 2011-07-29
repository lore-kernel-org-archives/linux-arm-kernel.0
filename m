From: viresh.linux@gmail.com (viresh kumar)
Date: Fri, 29 Jul 2011 08:25:09 -0700
Subject: [PATCH 02/18] dmaengine/amba-pl08x: Resolve formatting issues
In-Reply-To: <1311941138.1536.528.camel@vkoul-udesk3>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<1e5012faf0649e7ed0113960a9ac8302e46f1354.1311936524.git.viresh.kumar@st.com>
	<1311941138.1536.528.camel@vkoul-udesk3>
Message-ID: <CAOh2x=nn7Hy0_gHU2UDhwpj4MocN4rTYEK+VcwXpw9gon56b6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/29/11, Koul, Vinod <vinod.koul@intel.com> wrote:
> On Fri, 2011-07-29 at 16:19 +0530, Viresh Kumar wrote:
>>  				/*
>>  				 * So now we know how many bytes to transfer
>> -				 * to get to the nearest boundary.  The next
>> -				 * LLI will past the boundary.  However, we
>> +				 * to get to the nearest boundary. The next
>> +				 * LLI will past the boundary. However, we
>>  				 * may be working to a boundary on the slave
>> -				 * bus.  We need to ensure the master stays
>> +				 * bus. We need to ensure the master stays
>>  				 * aligned, and that we are working in
>>  				 * multiples of the bus widths.
>>  				 */
> This looks v ugly, care to fix this.
> 80chars should be followed with a little common sense, if it sacrifices
> code readability then pls ignore it.
> In places where you can fix it w/o sacrificing code quality pls do it :)

Ok.

>>  				/* FIXME: use round_down()? */
> while you are fixing the driver, care to fix the FIXME as well?

Already removed this. :)

--
viresh
