From: bp@alien8.de (Boris Petkov)
Date: Thu, 30 Aug 2018 18:12:28 +0300
Subject: [PATCH] EDAC, ghes: use CPER module handles to locate DIMMs
In-Reply-To: <000901d4406c$9d04f360$d70eda20$@codeaurora.org>
References: <1535567632-18089-1-git-send-email-wufan@codeaurora.org>
 <20180830104307.GC20005@nazgul.tnic>
 <000901d4406c$9d04f360$d70eda20$@codeaurora.org>
Message-ID: <9AEE3BFF-5F17-4C72-BE0A-76006BB64890@alien8.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On August 30, 2018 5:20:32 PM GMT+03:00, wufan <wufan@codeaurora.org> wrote:
>> > +static int ghes_edac_dimm_index(u16 handle)
>> 
>> get_dimm_smbios_handle()
>
>This function returns an index. So how about get_dimm_smbios_index()?

Sure.

-- 
Sent from a small device: formatting sux and brevity is inevitable. 
