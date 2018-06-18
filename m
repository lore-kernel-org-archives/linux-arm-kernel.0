From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 18 Jun 2018 21:31:27 +0200
Subject: [PATCH v3 06/14] mtd: rawnand: marvell: remove the dmaengine
 compat need
In-Reply-To: <3a2a8951-f380-af99-bf97-6ff722404410@zonque.org> (Daniel Mack's
 message of "Sun, 17 Jun 2018 20:12:49 +0200")
References: <20180617170217.24177-1-robert.jarzmik@free.fr>
 <20180617170217.24177-7-robert.jarzmik@free.fr>
 <3a2a8951-f380-af99-bf97-6ff722404410@zonque.org>
Message-ID: <87h8lzriwg.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Mack <daniel@zonque.org> writes:

> On Sunday, June 17, 2018 07:02 PM, Robert Jarzmik wrote:
>> As the pxa architecture switched towards the dmaengine slave map, the
>> old compatibility mechanism to acquire the dma requestor line number and
>> priority are not needed anymore.
>>
>> This patch simplifies the dma resource acquisition, using the more
>> generic function dma_request_slave_channel().
>>
>> Signed-off-by: Signed-off-by: Daniel Mack <daniel@zonque.org>
>
> Something went wrong here, but you can simply fix that when applying the series
> :)
Indeed, fixed before applying to the pxa/for-next tree.

--
Robert
