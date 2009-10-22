From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 23 Oct 2009 06:45:50 +0800
Subject: [PATCH] Zaurus: Fix NAND Flash OOB layout for Borzoi
In-Reply-To: <1256251085.23211.155.camel@dax.rpnet.com>
References: <1256245503.9561.18.camel@utx.utx.cz>
	<1256251085.23211.155.camel@dax.rpnet.com>
Message-ID: <f17812d70910221545i11f51c1bu8f57ae8cf5991b7d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 23, 2009 at 6:38 AM, Richard Purdie <rpurdie@rpsys.net> wrote:
> On Thu, 2009-10-22 at 23:05 +0200, Stanislav Brabec wrote:
>> Borzoi, Terrier and Akita use the same NAND Flash OOB layout, which
>> seems to be different from Spitz for some reason. Here is a fix.
>>
>> When the code was ported to the platform data, the map was applied just
>> for Akita.
>>
>> After this patch, Flash works again on Borzoi. Terrier still has a
>> problem with partition table? different from Borzoi (unfixable without
>> reading of the system configuration in flash) and JFFS2 partitions can
>> be mounted (with some "Empty flash at ... ends at ..." in the syslog).
>>
>> Signed-off-by: Stanislav Brabec <utx@penguin.cz>
>
> Akita and Borzoi/Terrier share the same kind of flash so this match
> almost certainly makes sense.
>
> Acked-by: Richard Purdie <rpurdie@rpsys.net>
>

Updated.
