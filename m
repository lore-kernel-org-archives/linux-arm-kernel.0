From: patrice.chotard@st.com (Patrice CHOTARD)
Date: Fri, 23 Mar 2018 07:38:43 +0000
Subject: linux-next: Signed-off-by missing for commit in the arm-soc tree
In-Reply-To: <20180322210144.GB3417@piout.net>
References: <20180316075629.019b6560@canb.auug.org.au>
 <CAK8P3a2-fUi0nnsLVJ6h_UuJCgwoNs2OEroYed2ofLd=FiPG0g@mail.gmail.com>
 <6b239ab5-5ded-b32b-eefc-601075d33f25@st.com>
 <20180322210144.GB3417@piout.net>
Message-ID: <e8eefe22-c1d1-d27b-68bb-036f6abb9814@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/22/2018 10:01 PM, Alexandre Belloni wrote:
> On 16/03/2018 at 07:34:06 +0000, Patrice CHOTARD wrote:
>> Hi Arnd, Stephen
>>
>> On 03/15/2018 10:06 PM, Arnd Bergmann wrote:
>>> On Thu, Mar 15, 2018 at 9:56 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>>> Hi all,
>>>>
>>>> Commit
>>>>
>>>>     9a5f4879cd8d ("ARM: dts: stih4xx: Add missing #sound-dai-cells")
>>>>
>>>> is missing a Signed-off-by from its committer.
>>>
>>> Thanks for the report.
>>>
>>> What script do you use to find those? I guess I should check for
>>> missing signoffs as well when pulling a branch.
>>>
>>> Patrice, I've dropped the merge now, and picked up the one
>>> patch in it directly, with my signoff. This should fix the issue this
>>> time, but please make sure you always sign off patches when
>>> you apply them from the list.
>>>
>>>           Arnd
>>>
>>
>> Ok i will update my script on my side with Stephen's script to avoid
>> this in the future.
>>
> 
> FWIW, last time this happened in the at91 tree, I've switched to use
> Stephen's script as a pre-push hook:
> https://raw.githubusercontent.com/alexandrebelloni/tools/master/pre-push_signed-off
> 
> 

Thanks Alexandre

Patrice
