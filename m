From: dhowells@redhat.com (David Howells)
Date: Fri, 25 Nov 2016 16:50:35 +0000
Subject: [PATCH 5/7] efi: Get the secure boot status [ver #3]
In-Reply-To: <31374.1480078855@warthog.procyon.org.uk>
References: <31374.1480078855@warthog.procyon.org.uk>
 <CAKv+Gu9c-C2uXZ0fVatCM8ffXJZDgjBcDb_T0nsFecGqgrF11Q@mail.gmail.com>
 <147990561294.7576.6464430479448167484.stgit@warthog.procyon.org.uk>
 <147990565051.7576.9673287945782426886.stgit@warthog.procyon.org.uk>
 <1480016487.2444.18.camel@HansenPartnership.com>
 <15173.1480066220@warthog.procyon.org.uk>
 <CAKv+Gu_JxNLDjaK5jGbX9ACzM0uHJYMOFx7XDo4t7DtBMtFRGA@mail.gmail.com>
 <16661.1480075392@warthog.procyon.org.uk>
 <CAKv+Gu_d5+Kvo7Tptnpg7kfjpqxhQ3a3nsQ0Ufsm6rBOFry+mQ@mail.gmail.com>
 <17565.1480077303@warthog.procyon.org.uk>
Message-ID: <7005.1480092635@warthog.procyon.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David Howells <dhowells@redhat.com> wrote:

> +	/* UEFI-2.6 requires DeployedMode to be 1. */
> +	if (sys_table_arg->hdr.revision == EFI_2_60_SYSTEM_TABLE_REVISION) {

Actually, I suspect that this should be '>='.

David
