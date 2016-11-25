From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 25 Nov 2016 12:52:58 +0000
Subject: [PATCH 5/7] efi: Get the secure boot status [ver #3]
In-Reply-To: <17942.1480078269@warthog.procyon.org.uk>
References: <147990561294.7576.6464430479448167484.stgit@warthog.procyon.org.uk>
 <147990565051.7576.9673287945782426886.stgit@warthog.procyon.org.uk>
 <1480016487.2444.18.camel@HansenPartnership.com>
 <15173.1480066220@warthog.procyon.org.uk>
 <CAKv+Gu_JxNLDjaK5jGbX9ACzM0uHJYMOFx7XDo4t7DtBMtFRGA@mail.gmail.com>
 <16661.1480075392@warthog.procyon.org.uk>
 <CAKv+Gu_d5+Kvo7Tptnpg7kfjpqxhQ3a3nsQ0Ufsm6rBOFry+mQ@mail.gmail.com>
 <17565.1480077303@warthog.procyon.org.uk>
 <CAKv+Gu9c-C2uXZ0fVatCM8ffXJZDgjBcDb_T0nsFecGqgrF11Q@mail.gmail.com>
 <17942.1480078269@warthog.procyon.org.uk>
Message-ID: <CAKv+Gu87-vUp6OrdVuUg0BxvSOHNPOFcsCFF9dzpohOQsY8Jtw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 November 2016 at 12:51, David Howells <dhowells@redhat.com> wrote:
> Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
>> There is a 'revision' field in the header ('hdr') of the EFI system
>> table, so something like
>
> Is this the same as the fw_revision in the system table?
>
>         #define EFI_2_60_SYSTEM_TABLE_REVISION ((2<<16) | (60))
>         #define EFI_2_50_SYSTEM_TABLE_REVISION ((2<<16) | (50))
>         #define EFI_2_40_SYSTEM_TABLE_REVISION ((2<<16) | (40))
>         ...
>

Yes. And in fact, that means my example is incorrect (60 not 6 in the
minor field)
