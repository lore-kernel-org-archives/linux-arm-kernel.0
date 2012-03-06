From: javier.martin@vista-silicon.com (javier Martin)
Date: Tue, 6 Mar 2012 12:29:34 +0100
Subject: Problems with "[PATCH 0/9] DMA engine cookie handling cleanups"
In-Reply-To: <20120306110753.GG17370@n2100.arm.linux.org.uk>
References: <CACKLOr3zFmNXYV6MW01uykp7geG=1gAkWcxYoMgLdqfzhMD9fw@mail.gmail.com>
 <20120306110753.GG17370@n2100.arm.linux.org.uk>
Message-ID: <CACKLOr2vi4HtwZKz9GXLxU7pfntPk-HLqu0mQrF7csq20a3SaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 March 2012 12:07, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Tue, Mar 06, 2012 at 12:03:54PM +0100, javier Martin wrote:
>> Hi Russell,
>> I've just seen this series in the mailing list archives:
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-March/087917.html
>>
>> As some people already stated, patch 1/9 is missing.
>
> They weren't all sent to linux-arm-kernel - they were only sent to the
> appropriate people listed in MAINTAINERS. ?So if you didn't receive them,
> either the patch was not touching a driver you maintain or your entries
> in MAINTAINERS is incomplete.

I'd like to have access to the patches in order to test them for the
imx and give you my tested-by.

>> In my case it is even worse: I didn't received any of the patches in
>> my mail-box despite being subscribed to the list.
>>
>> As you'll probably have noticed, I'm doing some deep cleanup on
>> 'imx-dma.c' file as you can see in the following patches:
>>
>> [PATCH v2 1/2] dmaengine: Add support for MEMCPY for imx-dma.
>> [PATCH v3 2/2] dmaengine: Add support for multiple descriptors for imx-dma.
>> [PATCH 00/14] dmaengine: imx-dma: merge dma arch code into dmaengine.
>>
>> Currently, I'm waiting for Sascha and Vinod to confirm that they are
>> fine and merge them. However, your series seems to conflict with those
>> patches as it modifies imx-dma.
>
> I expect that whenever these patches get posted, there will be some kind
> of conflict with some work going on somewhere else. ?There's not much
> which can be done to get away from that.

Who would be in charge of solving the merge issues that may arise?
Would it be Vinod Koul, the dmaengine maintainer?

Regards.
-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
