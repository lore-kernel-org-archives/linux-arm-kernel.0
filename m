From: viresh.kumar@st.com (viresh kumar)
Date: Fri, 29 Jul 2011 17:00:07 +0530
Subject: [PATCH 12/18] dmaengine/amba-pl08x: Add	prep_single_byte_llis()
	routine
In-Reply-To: <20110729110638.GH25640@n2100.arm.linux.org.uk>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<cacf3470c622f311c894e6c72f13ba02be82af73.1311936524.git.viresh.kumar@st.com>
	<20110729110638.GH25640@n2100.arm.linux.org.uk>
Message-ID: <4E3299BF.6030707@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29/2011 04:36 PM, Russell King - ARM Linux wrote:
>> > +static inline void prep_byte_width_lli(struct pl08x_lli_build_data *bd,
>> > +		u32 *cctl, u32 len, int num_llis, size_t *total_bytes)
>> > +{
>> > +		*cctl = pl08x_cctl_bits(*cctl, 1, 1, len);
>> > +		pl08x_fill_lli_for_desc(bd, num_llis, len, *cctl);
>> > +		(*total_bytes) += len;
> Seeing as your patch series started with a cleanup of spacing/tabbing,
> it's surprising to find a patch introducing new code which has broken
> tabbing.
> 

Haah.... How can i do this? Sorry will fix this.

-- 
viresh
