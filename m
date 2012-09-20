From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Wed, 19 Sep 2012 20:11:29 -0400
Subject: [PATCH 04/15] ARM: idmap: only initialize HYP idmap when HYP mode
 is available
In-Reply-To: <20120918130304.GM32204@mudshark.cambridge.arm.com>
References: <20120915153359.21241.86002.stgit@ubuntu>
 <20120915153455.21241.27798.stgit@ubuntu>
 <20120918130304.GM32204@mudshark.cambridge.arm.com>
Message-ID: <CANM98q+2SUSWs2-tF_hVqs6YZrt+D4Pee39MS1yY08tzAAnLvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2012 at 9:03 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Sat, Sep 15, 2012 at 04:34:55PM +0100, Christoffer Dall wrote:
>> From: Marc Zyngier <marc.zyngier@arm.com>
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm/mm/idmap.c |    4 ++++
>>  1 file changed, 4 insertions(+)
>
> Just fold this into the previous patch.
>
yep, that was silly.

Thanks,
-Christoffer
