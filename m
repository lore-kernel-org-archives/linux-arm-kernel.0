From: jcm@redhat.com (Jon Masters)
Date: Thu, 29 Jan 2015 18:16:22 -0500
Subject: [Linaro-acpi] [PATCH v7 04/17] ARM64 / ACPI: Introduce early_param
 for "acpi" and pass acpi=force to enable ACPI
In-Reply-To: <20150129231120.GA23786@e104818-lin.cambridge.arm.com>
References: <CAOZdJXU2bFR1T4ZnGavvnrUXAp5e=vNt9g6WKX46H8qs1wz-TQ@mail.gmail.com>
 <CAOZdJXXe+29rux1L3QYBX0yHLy3kdi+ZJrXVd=XfgYN=R6DtKA@mail.gmail.com>
 <20150128181453.GG31752@e104818-lin.cambridge.arm.com>
 <54C92804.5090806@codeaurora.org>
 <20150129151956.GF8951@e104818-lin.cambridge.arm.com>
 <CAKv+Gu_=si=L5+vvg+8hRgwmTahqdePw5bZxUMFSZ8obk-VXFQ@mail.gmail.com>
 <54CA7A42.5080800@codeaurora.org>
 <CAKv+Gu_a6_zjt=MsRuQH2rr05XxDayy0gACtbPXZaDAyhWrigg@mail.gmail.com>
 <54CA7D4A.5090709@codeaurora.org> <54CA7F94.6000305@redhat.com>
 <20150129231120.GA23786@e104818-lin.cambridge.arm.com>
Message-ID: <54CABF46.3050701@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/29/2015 06:11 PM, Catalin Marinas wrote:

> Sorry Jon but statements like this make me wonder whether we should
> simply let the whole ARM ACPI be an out of tree distro business. We
> spend a long time discussing OS-agnostic firmware implementation,
> planning mini-summits, just to get certain Linux distro representative
> stating that the kernel-firmware interface we discuss here only matters
> for those planning to follow upstream. Certain Linux distros will play
> by other rules.

Oh, don't take it that way - I just mean that if someone needs a
different ACPI always on, they can do that separately. I support your
position on upstream at this time! :)

Jon.
