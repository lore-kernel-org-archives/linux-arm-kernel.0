From: tphan@apm.com (Tuan Phan)
Date: Mon, 11 Jan 2016 14:41:41 -0800
Subject: [PATCH v3 1/2] acpi: Fix proper return code for function
 acpi_gsi_to_irq
In-Reply-To: <20160111221305.GH4665@pd.tnic>
References: <1446857519-5908-1-git-send-email-lho@apm.com>
 <1446857519-5908-2-git-send-email-lho@apm.com>
 <20160110110714.GA22896@pd.tnic>
 <CAGDN=zYa1r23EphdYQTFe2YXRhg_P-RDiaZVms9rdbFA3Y-x3g@mail.gmail.com>
 <20160111221305.GH4665@pd.tnic>
Message-ID: <CAGDN=zZOr6+q8aAdXB3gnSLfCm6gX-6KLaFPr+A4QMf+TPwR-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2016 at 2:13 PM, Borislav Petkov <bp@alien8.de> wrote:

>That function can be simplified. It should be made to return the irq
>number on success and 0 on failure. No need for that *irq output
>argument.

It will be problem because irq number can be 0 on X86?

-- 
CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is 
for the sole use of the intended recipient(s) and contains information that 
is confidential and proprietary to Applied Micro Circuits Corporation or 
its subsidiaries. It is to be used solely for the purpose of furthering the 
parties' business relationship. All unauthorized review, use, disclosure or 
distribution is prohibited. If you are not the intended recipient, please 
contact the sender by reply e-mail and destroy all copies of the original 
message.
