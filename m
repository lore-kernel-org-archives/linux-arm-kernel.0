From: bp@alien8.de (Borislav Petkov)
Date: Fri, 11 Aug 2017 11:09:26 +0200
Subject: [PATCH v2 2/6] edac: synopsys: Add platform specific structures
 for ddrc controller
In-Reply-To: <6c72eae7c1fbfd2b96d5dc1c7feb251bdbe3e591.1502091561.git.michal.simek@xilinx.com>
References: <91fd6532076e4c905b5a228d852bba4941c54a28.1502091561.git.michal.simek@xilinx.com>
 <6c72eae7c1fbfd2b96d5dc1c7feb251bdbe3e591.1502091561.git.michal.simek@xilinx.com>
Message-ID: <20170811090926.GC9432@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 07, 2017 at 09:39:24AM +0200, Michal Simek wrote:
> From: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> 
> Adds platform specific structures, so that we can add
> different IP support later using quirks.
> 
> Signed-off-by: Naga Sureshkumar Relli <nagasure@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v2:

Subject says "2/6" but I can't find 1/6 in my mbox. Nothing in spam
folder either. What's up?

Are you using the --cover-letter option to git format-patch ?

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
