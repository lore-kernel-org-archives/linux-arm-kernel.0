From: hramrach@gmail.com (Michal Suchanek)
Date: Mon, 17 Aug 2015 09:51:02 +0200
Subject: [linux-sunxi] Re: ARM: sunxi: Experiences NAND flash
In-Reply-To: <20150817093411.4ff853c4@bbrezillon>
References: <55C9E7B4.9090906@schinagl.nl> <20150817093411.4ff853c4@bbrezillon>
Message-ID: <CAOMqctTzPn1Z2onaMwoPFfndBLGGH5gt2GM2fkV1TMnhvsYAHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

On 17 August 2015 at 09:34, Boris Brezillon
<boris.brezillon@free-electrons.com> wrote:
> Hi Oliver,
>
> Sorry for the late reply (I was in vacation for the last 2 weeks)
>
> On Tue, 11 Aug 2015 14:16:52 +0200
> Olliver Schinagl <oliver+list@schinagl.nl> wrote:
>

>>
>> Now I know that the mtd stuff is all very new and all very untested,
>> what I am curious about is a) have other people actually tried the mtd
>> stuff on Allwinner hardware, and b) has anybody encountered this issue
>> as well?
>
> Yes we did. So far we're using the NAND in SLC mode to address this
> problem. It seems to work, but you also loose half the NAND capacity.
>


What is needed to use the NAND in SLC mode?

Presumably you need to know something about its organizetion?

Is this data available for chips commonly used on sunxi devices?

Thanks

Michal
