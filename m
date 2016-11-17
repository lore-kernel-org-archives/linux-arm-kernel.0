From: mbrugger@suse.com (Matthias Brugger)
Date: Thu, 17 Nov 2016 12:32:15 +0100
Subject: [PATCH fpga 1/9] fpga zynq: Add missing \n to messages
In-Reply-To: <20161115180813.GB1852@obsidianresearch.com>
References: <1478732303-13718-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <1478732303-13718-2-git-send-email-jgunthorpe@obsidianresearch.com>
 <0aebdb59-86d7-2569-c49d-de5d45b5cac0@suse.com>
 <20161115180813.GB1852@obsidianresearch.com>
Message-ID: <21fe76d9-f32a-9684-5853-4448eb6aac67@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 15/11/16 19:08, Jason Gunthorpe wrote:
>
> On Tue, Nov 15, 2016 at 12:05:15PM +0100, Matthias Brugger wrote:
>> On 09/11/16 23:58, Jason Gunthorpe wrote:
>>> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
>>
>> Please add a commit message, although it is cristal clear what this patch
>> does :)
>
> As you say, it is crystal clear already, and this is an acceptable commit
> message.. Please suggest a text if you want to see something
> different.
>

"Function dev_err doesn't add a newline at the end of the string. This 
will lead to a hard to read kernel log. This patch fixes this."

With this (or something similar added):
Reviewed-by: Matthias Brugger <mbrugger@suse.com>

Regards,
Matthias
