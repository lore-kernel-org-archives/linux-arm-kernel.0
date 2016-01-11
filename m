From: bp@alien8.de (Borislav Petkov)
Date: Mon, 11 Jan 2016 23:13:05 +0100
Subject: [PATCH v3 1/2] acpi: Fix proper return code for function
 acpi_gsi_to_irq
In-Reply-To: <CAGDN=zYa1r23EphdYQTFe2YXRhg_P-RDiaZVms9rdbFA3Y-x3g@mail.gmail.com>
References: <1446857519-5908-1-git-send-email-lho@apm.com>
 <1446857519-5908-2-git-send-email-lho@apm.com>
 <20160110110714.GA22896@pd.tnic>
 <CAGDN=zYa1r23EphdYQTFe2YXRhg_P-RDiaZVms9rdbFA3Y-x3g@mail.gmail.com>
Message-ID: <20160111221305.GH4665@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2016 at 02:04:52PM -0800, Tuan Phan wrote:
> Hi Boris,
> The same function which is implemented for x86
> (arch/x86/kernel/acpi/boot.c) also returns 0 on success and -1 on
> failure. If we need to change the API, need to change for X86 too
> which we don't have a way to test it.

Well, fortunately, I have an x86 box to test it :-)

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
