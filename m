From: viresh.linux@gmail.com (viresh kumar)
Date: Fri, 29 Jul 2011 08:47:06 -0700
Subject: [PATCH 04/18] dmaengine/amba-pl08x: Remove redundant comment and
	rewrite original
In-Reply-To: <1311941355.1536.529.camel@vkoul-udesk3>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<e2c1bd6941e88f8988b1942c13c20cf436b3a963.1311936524.git.viresh.kumar@st.com>
	<1311941355.1536.529.camel@vkoul-udesk3>
Message-ID: <CAOh2x=kqa0GxRH9o=8faPhuyyLcqxH8+AOowBTK_gMaDgJyeVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/29/11, Koul, Vinod <vinod.koul@intel.com> wrote:
> On Fri, 2011-07-29 at 16:19 +0530, Viresh Kumar wrote:
>>  /*
>> - * Autoselect a master bus to use for the transfer this prefers the
>> - * destination bus if both available if fixed address on one bus the
>> - * other will be chosen
>> + * Autoselect a master bus to use for the transfer
>> + * - prefers the destination bus if both available
>> + * - if fixed address on one bus the other will be chosen
> Not sure I get it, English is not my first language :)

Nor mine either. :)

Will give some more explanation.

But before that i wanted to know the exact purpose of this
master-slave concept here.
Probably it is for choosing the victim for reduction of width, in case
src and dest addresses
are misaligned to each other.
@Russell and Linus: Is this correct?

--
viresh
