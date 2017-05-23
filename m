From: bp@alien8.de (Borislav Petkov)
Date: Tue, 23 May 2017 11:30:43 +0200
Subject: [PATCH V17 00/11] Add UEFI 2.6 and ACPI 6.1 updates for RAS on
 ARM64
In-Reply-To: <1495225933-4410-1-git-send-email-tbaicar@codeaurora.org>
References: <1495225933-4410-1-git-send-email-tbaicar@codeaurora.org>
Message-ID: <20170523093043.GB25383@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 02:32:02PM -0600, Tyler Baicar wrote:
> When a memory error, CPU error, PCIe error, or other type of hardware error
> that's covered by RAS occurs, firmware should populate the shared GHES memory
> location with the proper GHES structures to notify the OS of the error.

...

> V17:Rebase on tip
>     Change trace event helper function names
>     Remove unneeded prefixes from commit text

The whole series:

Reviewed-by: Borislav Petkov <bp@suse.de>

Thanks!

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
