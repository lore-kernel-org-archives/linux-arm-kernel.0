From: saeed.bishara@gmail.com (saeed bishara)
Date: Wed, 1 Sep 2010 10:42:15 +0300
Subject: [PATCH 2/2] set packet size limit for the mv643xx csum offloading
In-Reply-To: <20100831164816.GU1586@mail.wantstofly.org>
References: <1275827336-31111-1-git-send-email-saeed@marvell.com>
	<1275827336-31111-2-git-send-email-saeed@marvell.com>
	<20100715202621.GA772@jirafa.cyrius.com>
	<20100716060856.GP14513@mail.wantstofly.org>
	<AANLkTiknBccMbH0ZB_bbe6xC4W1EgtFn=sxVUHCDi8cJ@mail.gmail.com>
	<20100831164816.GU1586@mail.wantstofly.org>
Message-ID: <AANLkTinvM2DK9c2oxsVMVpF1gzf5VEHiHukqOc59mT79@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 31, 2010 at 7:48 PM, Lennert Buytenhek
<buytenh@wantstofly.org> wrote:
> On Tue, Aug 31, 2010 at 04:13:28PM +0300, saeed bishara wrote:
>
>> > > I noticed that patch 1/2 has gone into mainline but I cannot find 2/2
>> > > in any tree. ?Saeed, can you add the definition for Loki that someone
>> > > pointed out (9*1024) and resubmit?
>> >
>> > If you're going to supply the value explicitly for all platforms, you
>> > might as well supply it explicitly for mv78xx0 (9*1024) and orion5x
>> > (9*1024) as well.
>>
>> The default value is 9*1024, so I see there is need to supply it for
>> mv78xx0 and Loki. agree?
>
> I would supply it in any case, for clarity -- and if there are two
> (or more) different values out there, then neither value really has
> more right to be the default than the other.
ok, attached the updated version of this patch.
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-set-packet-size-limit-for-the-mv643xx-csum-offloadin.patch
Type: application/octet-stream
Size: 4511 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100901/c629e319/attachment-0001.obj>
