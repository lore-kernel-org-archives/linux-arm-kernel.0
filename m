From: peda@axentia.se (Peter Rosin)
Date: Wed, 11 Apr 2018 17:10:43 +0200
Subject: [PATCH] mtd: nand: raw: atmel: add module param to avoid using dma
In-Reply-To: <20180411165925.2be0d45b@bbrezillon>
References: <20180329131054.22506-1-peda@axentia.se>
 <20180329153322.5e2fc1e7@bbrezillon>
 <ed87cf13-a69a-6115-f0a8-5f51c4957d1d@axentia.se>
 <20180329154416.5c1a0013@bbrezillon>
 <b740406a-e91c-67ad-24a3-cbdbe259d00d@axentia.se>
 <20180402142249.7e076a64@bbrezillon>
 <e0d9bd59-8031-e387-676e-dc5811170a0c@axentia.se>
 <20180402212843.164d5d21@bbrezillon> <20180402222020.1d344c14@bbrezillon>
 <d7e6f78d-b57b-4d0f-c07c-ca6c1930cd51@axentia.se>
 <20180403091813.5fb5c18c@bbrezillon>
 <d0afd431-6e51-a9b7-c103-ecf1f6e07c2e@axentia.se>
 <20180411165925.2be0d45b@bbrezillon>
Message-ID: <bb64d0b1-bb3a-06b0-9e90-0caf7531f3c5@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-04-11 16:59, Boris Brezillon wrote:
> On Wed, 11 Apr 2018 16:44:10 +0200
> Peter Rosin <peda@axentia.se> wrote:
> 
>> Hi Nicolas,
>>
>> Boris asked for your input on this (the datasheet difference appears to
>> have no bearing on the issue) elsewhere in the tree of messages. It's
>> now been a week or so and I'm starting to wonder if you missed this
>> altogether or if you are simply out of office or something?
> 
> I was wondering if you had given up on this problem, it seems you did
> not.

I have my local patch to disable dma for the flash, but local patches
are always a disappointment.

>      Did you try forcing the HLCDC to use the 2nd interface (ahb_id=1)
> instead of the first one?

Just tried, and it's better that way, but the problem still exist and is
very visible on some (but apparently not all) flash accesses.

Cheers,
Peter
