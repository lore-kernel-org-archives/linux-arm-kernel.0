From: jassisinghbrar@gmail.com (jassi brar)
Date: Wed, 12 May 2010 15:31:58 +0900
Subject: [PATCH 06/16] ARM: Samsung: move S5PC100 support from
	plat-s5pc1xx to plat-s5p framework
In-Reply-To: <002b01caf197$a48bedf0$eda3c9d0$%szyprowski@samsung.com>
References: <1270190944-21644-1-git-send-email-m.szyprowski@samsung.com>
	<1270190944-21644-7-git-send-email-m.szyprowski@samsung.com>
	<001801caf195$da9e9ed0$8fdbdc70$%kim@samsung.com>
	<002b01caf197$a48bedf0$eda3c9d0$%szyprowski@samsung.com>
Message-ID: <AANLkTimA7o4YDQ8Lla1wJ0i8rDyX9dM7_z89aqPA6DkE@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 12, 2010 at 2:54 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>> > @@ -79,6 +77,7 @@ static struct s3c2410_uartcfg smdkc100_uartcfgs[]
>> __initdata
>> > = {
>> > ? ? },
>> > ?};
>> >
>> > +#if 0
>>
>> #if 0?
>
> I had to disable that part of code to make it compile. It is enabled later
> in separate patch when the relevant functionality got moved from plat-s5pc1xx
> to mach-s5pc100.
build break is just one thing to avoid, one should make sure the functionality
doesn't break either during the changes.
Is the functionality affected during these changes?
