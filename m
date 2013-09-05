From: ethan@ethantuttle.com (Ethan Tuttle)
Date: Wed, 4 Sep 2013 23:52:48 -0700
Subject: [PATCH] net: mvneta: properly disable HW PHY polling and ensure
 adjust_link() works
In-Reply-To: <20130905064036.GC26000@1wt.eu>
References: <1378304478-21237-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130904163245.GI20552@1wt.eu>
 <CACzLR4uDQK2bkcEJQXLe805EfSA8=eF+YH-FTYovHA0q+8Y9NA@mail.gmail.com>
 <20130905051223.GB26000@1wt.eu>
 <CACzLR4uCQhGzgABV2nMG45EQBNsrW8=j5X7x-=eTSUmSvthLxg@mail.gmail.com>
 <ca521df880b08225cb34214e3ef0fc2c@cheny.fr>
 <20130905064036.GC26000@1wt.eu>
Message-ID: <CACzLR4s_aR--g-wGWHvJnoOdkLvjLm6fdcpMT6ARxS8D4-g6wQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Works like a charm!  Thanks for sharing these.

It may be a while until an alternative to Marvell's uboot is available
for the Mirabox, so it's a shame these patches won't be making it into
the mainline kernel.

Regards,

Ethan

On Wed, Sep 4, 2013 at 11:40 PM, Willy Tarreau <w@1wt.eu> wrote:
> On Thu, Sep 05, 2013 at 08:23:12AM +0200, yves at cheny.fr wrote:
>> Hi Willy,
>> i would be interested too !
>>
>> thx
>> Yves
>>
>> Le 2013-09-05 07:22, Ethan Tuttle a ?crit :
>> >Understood.  Ultimately, I'll use this board as a router, and stable
>> >mac addresses would be better than random.  So I would be interested
>> >to try your atag -> device tree patches.  Have they been posted
>> >somewhere I can find them?
>
> OK guys, here they come. Note that they're now simplified since the
> eth* aliases have been added to the dts.
>
> Willy
>
