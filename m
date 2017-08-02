From: slash.tmp@free.fr (Mason)
Date: Wed, 2 Aug 2017 18:07:52 +0200
Subject: [RFC PATCH v2 0/2] nb8800 suspend/resume support
In-Reply-To: <yw1xo9rygdyu.fsf@mansr.com>
References: <33d1ab47-6098-5e3f-8a3c-f72626d07113@free.fr>
 <aa8885b8-e6bb-3624-2bf9-0bb40505ac54@free.fr>
 <dd883398-1511-0bfd-972b-a11ef8709f0d@free.fr> <yw1xshhagexd.fsf@mansr.com>
 <9e8e12b1-74e2-8323-ec16-eebda46b2a3d@free.fr> <yw1xo9rygdyu.fsf@mansr.com>
Message-ID: <6906dccf-bec9-0fc8-a34a-c39c05ada917@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/08/2017 17:56, M?ns Rullg?rd wrote:

> Mason writes:
> 
>> From my perspective, the older method does not work on newer chips :-)
> 
> It does work on tango4.

Agreed.

> What does the tango5 do if you flood it with packets faster than the
> kernel can keep up with?  That would make it hit the end of the rx
> chain, which is apparently what makes it miserable with the current dma
> stop code.

The simplest way to test this would be sending tiny packets
as fast as possible, right? So ping -f on a GigE link should
fit the bill?

Regards.
