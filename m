From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Fri, 20 Jan 2017 12:06:13 +0100
Subject: [GIT PULL] STM32 DT changes for v4.11 #1
In-Reply-To: <CAK8P3a24uSmOYdhJQD2gE8qunb_ObXQ1zg8MAbzpPy5OR25-Qw@mail.gmail.com>
References: <e36f6aca-120c-b2a5-52da-06e12e5cfb9f@st.com>
 <20170117065309.GS16607@localhost>
 <CAK8P3a24uSmOYdhJQD2gE8qunb_ObXQ1zg8MAbzpPy5OR25-Qw@mail.gmail.com>
Message-ID: <ff7fb3d8-d4bc-701e-6c80-b91f4e23b412@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/20/2017 11:30 AM, Arnd Bergmann wrote:
> On Tue, Jan 17, 2017 at 7:53 AM, Olof Johansson <olof@lixom.net> wrote:
>> On Mon, Jan 16, 2017 at 04:49:29PM +0100, Alexandre Torgue wrote:
>>> -----
>>> First patch "clk: stm32f4: Update DT bindings documentation")
>>> has already been merged in clock tree.
>>
>> Ugh. That patch doesn't just update documentation. It also updates the
>> dt-include file.
>>
>> So, if it's already been merged into the clock tree, then we can't merge
>> a separate copy here.
>>
>> By now, easiest is to hold off making use of it until it's on a shared
>> branch, i.e. next release. Use the numerical values until then.
>
> I suggested doing it this way if the same commit ID could be used rather
> than having two identical commits with different IDs in the two branches,
> which would be bad practice.
>
> Alexandre, can you clarify whether this is the same commit ID on both
> branches, and whether the tree it was merged into is one that does
> not get rebased?

Actually, commit SHA1 are different in clk tree and stm32-dt tree.
Do I need to "re-build" my branch based on 4.10-rc1 + "dt bindings patch 
with clk (with the same sha1 than in clock tree) " ?

Alex

>
>     Arnd
>
