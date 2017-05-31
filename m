From: lho@apm.com (Loc Ho)
Date: Wed, 31 May 2017 09:13:35 -0700
Subject: [PATCH v2 pci] PCI/MSI: pci-xgene-msi: Enable MSI support in ACPI
 boot for X-Gene v1
In-Reply-To: <a33cec72-e4ab-60cb-7173-41043f4a9120@redhat.com>
References: <1493340847-25720-1-git-send-email-kdinh@apm.com>
 <a33cec72-e4ab-60cb-7173-41043f4a9120@redhat.com>
Message-ID: <CAPw-ZTnvCuwZ5ziZ+mVeZxwNiEKYFA+Qc7vUtP01XQ22Bnpd8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

> > From: Khuong Dinh <kdinh@apm.com>
> >
> > This patch makes pci-xgene-msi driver ACPI-aware and provides
> > MSI capability for X-Gene v1 PCIe controllers in ACPI boot mode.
> >
> > Signed-off-by: Khuong Dinh <kdinh@apm.com>
> > Signed-off-by: Duc Dang <dhdang@apm.com>
> > Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> > ---
> > v2:
> >  - Verify with BIOS version 3.06.25 and 3.07.09
> > v1:
> >  - Initial version
>
>
> Hoping I just missed it, but was a follow-up (v3) ever provided for
> this? It seems this thread ended with the expectation that a v3 would be
> provided to address the sequencing issue.


No... You didn't missed anything. Khuong is out last couple days. He
is currently implementing the dependence requirement using the _DED
method. As soon as he get this working correctly, he will post the
next version. Though, there isn't anything wrong with the last version
besides future potential change in the kernel which is very unlikely
to change for the next one or more release of the future kernel.

-Loc
