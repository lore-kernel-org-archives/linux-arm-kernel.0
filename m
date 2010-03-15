From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 15 Mar 2010 12:14:54 +0530
Subject: QUERY: How to handle sharing of interrupt between different
	peripherals.
In-Reply-To: <1b68c6791003142218q24fd8516id75d6964201da3f2@mail.gmail.com>
References: <4B9DB99A.5040104@st.com>
	<1b68c6791003142218q24fd8516id75d6964201da3f2@mail.gmail.com>
Message-ID: <4B9DD766.7010504@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/15/2010 10:48 AM, jassi brar wrote:
> On Mon, Mar 15, 2010 at 1:37 PM, Viresh KUMAR <viresh.kumar@st.com> wrote:
>> In our SOC (SPEArxxx), we have few peripherals which share common interrupt
>> line.
> how about set_irq_chained_handler ?

I think it is not for this purpose. Better to use IRQF_SHARED in normal
request_irq. what do you say?
