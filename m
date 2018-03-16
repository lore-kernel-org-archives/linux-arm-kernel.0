From: patrice.chotard@st.com (Patrice CHOTARD)
Date: Fri, 16 Mar 2018 07:34:06 +0000
Subject: linux-next: Signed-off-by missing for commit in the arm-soc tree
In-Reply-To: <CAK8P3a2-fUi0nnsLVJ6h_UuJCgwoNs2OEroYed2ofLd=FiPG0g@mail.gmail.com>
References: <20180316075629.019b6560@canb.auug.org.au>
 <CAK8P3a2-fUi0nnsLVJ6h_UuJCgwoNs2OEroYed2ofLd=FiPG0g@mail.gmail.com>
Message-ID: <6b239ab5-5ded-b32b-eefc-601075d33f25@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Stephen

On 03/15/2018 10:06 PM, Arnd Bergmann wrote:
> On Thu, Mar 15, 2018 at 9:56 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> Hi all,
>>
>> Commit
>>
>>    9a5f4879cd8d ("ARM: dts: stih4xx: Add missing #sound-dai-cells")
>>
>> is missing a Signed-off-by from its committer.
> 
> Thanks for the report.
> 
> What script do you use to find those? I guess I should check for
> missing signoffs as well when pulling a branch.
> 
> Patrice, I've dropped the merge now, and picked up the one
> patch in it directly, with my signoff. This should fix the issue this
> time, but please make sure you always sign off patches when
> you apply them from the list.
> 
>          Arnd
> 

Ok i will update my script on my side with Stephen's script to avoid 
this in the future.

Thanks

Patrice
