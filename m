From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 28 Aug 2013 23:40:36 +0400
Subject: [PATCH 11/19] ARM: alignment: correctly decode instructions in
 BE8 mode.
In-Reply-To: <1377690359-25397-12-git-send-email-ben.dooks@codethink.co.uk>
References: <1377639509-22778-1-git-send-email-ben.dooks@codethink.co.uk>
 <1377690359-25397-1-git-send-email-ben.dooks@codethink.co.uk>
 <1377690359-25397-12-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <521E5234.1010008@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 08/28/2013 03:45 PM, Ben Dooks wrote:

> If we are in BE8 mode, we must deal with the instruction stream being
> in LE order when data is being loaded in BE order. Ensure the data is
> swapped before processing to avoid thre following:

> Change to using <asm/opcodes.h> to provide the necessary conversion
> functions to change the byte ordering.

> Alignment trap: not handling instruction 030091e8 at [<80333e8c>]
> Unhandled fault: alignment exception (0x001) at 0xbfa09567

    I guess the above 2 paragraphs are swapped.

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

WBR, Sergei
