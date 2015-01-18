From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Sun, 18 Jan 2015 14:46:35 +0800
Subject: [PATCH v7 06/17] ARM64 / ACPI: Make PCI optional for ACPI on ARM64
In-Reply-To: <508480149.12941388.1421562696311.JavaMail.zimbra@zmail15.collab.prod.int.phx2.redhat.com>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <1421247905-3749-7-git-send-email-hanjun.guo@linaro.org>
 <20150116094913.GA13634@e104818-lin.cambridge.arm.com>
 <54BB51F1.8000900@linaro.org>
 <508480149.12941388.1421562696311.JavaMail.zimbra@zmail15.collab.prod.int.phx2.redhat.com>
Message-ID: <54BB56CB.7040701@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?01?18? 14:31, Jon Masters wrote:
> Hi Folks,
>
> Sorry for top posting from bed. The mainstream servers will all likely do
 > PCIe but there are several that may not. They should not be excluded. 
That said,
 >if we booted a previously built kernel on a system without an MCFG and
 > got no ECAM/root then things would probably still work.
>
> I think it'll work out either way but for the record there is no requirement to do PCIe on ARM servers that conform to spec.

OK, Catalin already said that was not the main point of the
comments for this patch, I think the title and change log
of the patch is inconsistent with the code makes Catalin confused,
I will update them in next version.

Thanks
Hanjun
