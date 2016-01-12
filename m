From: bp@alien8.de (Borislav Petkov)
Date: Tue, 12 Jan 2016 20:21:17 +0100
Subject: [PATCH v3 1/2] acpi: Fix proper return code for function
 acpi_gsi_to_irq
In-Reply-To: <CAGDN=zbbfr8HVKhg4YEieyxzb6jT6eMJ2mTyn6zV9HFD_AA3aA@mail.gmail.com>
References: <1446857519-5908-1-git-send-email-lho@apm.com>
 <1446857519-5908-2-git-send-email-lho@apm.com>
 <20160110110714.GA22896@pd.tnic>
 <CAGDN=zYa1r23EphdYQTFe2YXRhg_P-RDiaZVms9rdbFA3Y-x3g@mail.gmail.com>
 <20160111221305.GH4665@pd.tnic>
 <CAGDN=zZOr6+q8aAdXB3gnSLfCm6gX-6KLaFPr+A4QMf+TPwR-w@mail.gmail.com>
 <20160112143653.GB30558@pd.tnic>
 <CAGDN=za9Pjm0B0OMJevgesBdkm=XOGyU7jXXfWqk+dLSo7BVtQ@mail.gmail.com>
 <20160112183228.GK30558@pd.tnic>
 <CAGDN=zbbfr8HVKhg4YEieyxzb6jT6eMJ2mTyn6zV9HFD_AA3aA@mail.gmail.com>
Message-ID: <20160112192117.GL30558@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2016 at 10:46:15AM -0800, Tuan Phan wrote:
> Well, it basically the same as old code except the change of API
> interface. And it requires some changes in ACPI core and X86/I64 arch
> code.

That's why I said:

"Patch 1 could be improved. It is Rafael's call in the end of the day."

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
