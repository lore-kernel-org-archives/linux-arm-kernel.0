From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 20 Apr 2012 08:58:17 +0530
Subject: [PATCH V2 6/6] SPEAr: Switch to common clock framework
In-Reply-To: <201204191959.15182.arnd@arndb.de>
References: <cover.1334852393.git.viresh.kumar@st.com>
 <ddade82f0666c3186b8a694aa2b79acd3f7e5d50.1334852395.git.viresh.kumar@st.com>
 <201204191959.15182.arnd@arndb.de>
Message-ID: <4F90D7D1.4020709@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/20/2012 1:29 AM, Arnd Bergmann wrote:
> On Thursday 19 April 2012, Viresh Kumar wrote:
>> > SPEAr SoCs used its own clock framework since now. From now on they will move to
>> > use common clock framework.
>> > 
>> > This patch updates existing SPEAr machine support to adapt for common clock
>> > framework.
>> > 
>> > Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
>> >  21 files changed, 994 insertions(+), 2951 deletions(-)
> Great diffstat!

Thanks Arnd.

For this set to go through Mike's tree, we would require earlier pull request
of 3xx DT and pinmux to be upstreamed. When are you planning to do that?
After that i will ask Mike to apply these patches on latest linux-next. :)

-- 
viresh
