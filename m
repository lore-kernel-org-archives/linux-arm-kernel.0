From: kyungmin.park@samsung.com (Kyungmin Park)
Date: Fri, 26 Mar 2010 09:29:56 +0900
Subject: [PATCH v2] PL330: Add PL330 DMA controller driver
In-Reply-To: <1b68c6791003251659w4c6c8d12rf97458c2380f25e0@mail.gmail.com>
References: <4BAAD5BB.7050101@samsung.com>
	<1b68c6791003242234h106d9530p12b5a046a906227e@mail.gmail.com>
	<63386a3d1003250130w6f34854ag2ca163799e9b7bed@mail.gmail.com>
	<1b68c6791003250517y4e2789baoe147e5982c363682@mail.gmail.com>
	<4BAB7D9F.4070807@intel.com>
	<1b68c6791003251527s1ef985d2m4a309a3c09e31e0a@mail.gmail.com>
	<e9c3a7c21003251612l59d77753o8f56e2643a96fe0d@mail.gmail.com>
	<1b68c6791003251659w4c6c8d12rf97458c2380f25e0@mail.gmail.com>
Message-ID: <9c9fda241003251729y28ccbadfs7ac72ad99b6d6ffa@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 26, 2010 at 8:59 AM, jassi brar <jassisinghbrar@gmail.com> wrote:
> On Fri, Mar 26, 2010 at 8:12 AM, Dan Williams <dan.j.williams@intel.com> wrote:
>> On Thu, Mar 25, 2010 at 3:27 PM, jassi brar <jassisinghbrar@gmail.com> wrote:
>>> On Fri, Mar 26, 2010 at 12:13 AM, Dan Williams <dan.j.williams@intel.com> wrote:
>>>> It sounds like you just need to add an extension for the arch specific dma
>>>> api.
>>> I actually plan more than that.
>>> Apart from inefficient design, JoonYoung's driver has made some fatal
>>> assumptions
>>> about PL330, which will result in DMA aborts if used with SoCs that implement
>>> configuration of PL330 that is very different from Samsung SoCs'
Exactly what? We are already tested it our board and play the music well.
What's condition DMA aborts are happen?
>>> Of course, I address all such issues that I can think of, in my implementation.
>>
>> Ok, I'll rely on acked-by's from the interested parties once your
>> driver is out as I do not have a vested interest in this hardware,
>> just the dmaengine framework issues.
> Fair enough. Thank you.

As your previous mail, we can wait until this weekend. but If you
don't post the your codes until this weekend.
We assume that your works are not yet done so merge this patch first
and then fix it if your words(DMA aborts issue) are right.

Thank you,
Kyungmin Park
