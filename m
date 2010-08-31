From: vipin.kumar@st.com (Vipin Kumar)
Date: Tue, 31 Aug 2010 12:04:32 +0530
Subject: [PATCH 28/74] Incrementing the ecc_pos array to contain 128 char
In-Reply-To: <1283170469.12995.53.camel@brekeke>
References: <07ce8daf18d3a9f13864752074af3490a324d84c.1283161023.git.viresh.kumar@st.com>	
	<a750eadbd743c3a2d5dc8b35c25e0ee82f569e87.1283161023.git.viresh.kumar@st.com>
	<1283170469.12995.53.camel@brekeke>
Message-ID: <4C7CA278.9040902@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/30/2010 5:44 PM, Artem Bityutskiy wrote:
> On Mon, 2010-08-30 at 16:13 +0530, Viresh KUMAR wrote:
>> From: Vipin Kumar <vipin.kumar@st.com>
>>
>> For a page size of 4096, the number of oob bytes are 128 per page. This demands
>> for an increased ecc_pos array as well as ecc can be placed at more than 64
>> locations.
>>
>> This patch is added because SPEAr platforms NAND controller has 13 bytes of ecc
>> for each 512 bytes of data. This results in 104 bytes of ecc in case of 4096
>> byte page.
>>
>> Signed-off-by: Vipin Kumar <vipin.kumar@st.com>
>> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> 
> Nack, breaking ABI Is not allowed in Linux.
> 
Hello Artem,

I could not understand your point. Can you please elaborate. How does this patch 
break ABI

Regards
Vipin
