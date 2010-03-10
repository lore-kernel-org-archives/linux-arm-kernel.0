From: viresh.kumar@st.com (Viresh KUMAR)
Date: Wed, 10 Mar 2010 10:39:23 +0530
Subject: [PATCH 01/11] ST SPEAr: Added ARM PrimeXsys System Controller
	SP810 header file
In-Reply-To: <63386a3d1003091214s5251674et99903756f3528e66@mail.gmail.com>
References: <1267592861-26911-1-git-send-email-viresh.kumar@st.com>	
	<1267592861-26911-2-git-send-email-viresh.kumar@st.com>
	<63386a3d1003091214s5251674et99903756f3528e66@mail.gmail.com>
Message-ID: <4B972983.7090307@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

On 3/10/2010 1:44 AM, Linus Walleij wrote:
> 2010/3/3 Viresh KUMAR <viresh.kumar@st.com>:
> 
>> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
>> ---
>>  include/linux/sysctl_sp810.h |   59 ++++++++++++++++++++++++++++++++++++++++++
>>  1 files changed, 59 insertions(+), 0 deletions(-)
>>  create mode 100644 include/linux/sysctl_sp810.h
>> (...)
> 
> To the rest of the world this is probably a number of register definitions and
> an obscure inline function, so the entire internal kernel API does not need
> to know about it.
> 
> Move it to arch/arm/include/asm/hardware

OK.


viresh
