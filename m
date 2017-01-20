From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Jan 2017 12:55:23 +0100
Subject: [GIT PULL] STM32 DT changes for v4.11 #1
In-Reply-To: <ff7fb3d8-d4bc-701e-6c80-b91f4e23b412@st.com>
References: <e36f6aca-120c-b2a5-52da-06e12e5cfb9f@st.com>
 <20170117065309.GS16607@localhost>
 <CAK8P3a24uSmOYdhJQD2gE8qunb_ObXQ1zg8MAbzpPy5OR25-Qw@mail.gmail.com>
 <ff7fb3d8-d4bc-701e-6c80-b91f4e23b412@st.com>
Message-ID: <CAK8P3a3zzEjYUhNr2btA009pQMbRpJBVw0=EuoW95GUb4fhUVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2017 at 12:06 PM, Alexandre Torgue
<alexandre.torgue@st.com> wrote:
> On 01/20/2017 11:30 AM, Arnd Bergmann wrote:
>> On Tue, Jan 17, 2017 at 7:53 AM, Olof Johansson <olof@lixom.net> wrote:
>>> On Mon, Jan 16, 2017 at 04:49:29PM +0100, Alexandre Torgue wrote:
>> Alexandre, can you clarify whether this is the same commit ID on both
>> branches, and whether the tree it was merged into is one that does
>> not get rebased?
>
>
> Actually, commit SHA1 are different in clk tree and stm32-dt tree.
> Do I need to "re-build" my branch based on 4.10-rc1 + "dt bindings patch
> with clk (with the same sha1 than in clock tree) " ?

Yes, that is the right way to do it. I think you should start with -rc1 and
then do a 'git merge' of the commit that you need, as for some reason
that ended up not being on an -rc but on top of the older clk-fixes branch
that was merged into v4.9.

    Arnd
