From: teawater@gmail.com (Hui Zhu)
Date: Mon, 4 Jan 2010 01:39:44 +0800
Subject: [PATCH] stack2core: show stack message and convert it to core
	file when kernel die
In-Reply-To: <20100103092608.0a04c664@infradead.org>
References: <daef60381001030705r93b3fbfkc50e7b9bbc62b334@mail.gmail.com>
	<20100103160313.GA21156@n2100.arm.linux.org.uk>
	<daef60381001030830u176c0cfavbb31358a2b42ed60@mail.gmail.com>
	<20100103164414.GB21156@n2100.arm.linux.org.uk>
	<daef60381001030855o3a39c3fdr879e2634fb85c491@mail.gmail.com>
	<20100103092608.0a04c664@infradead.org>
Message-ID: <daef60381001030939r60315c1dy56025a041a8ee758@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

scripts/markup_oops.pl just support x86?
s2c support x86, x8664, arm, mips, mips64.

Thanks,
Hui

On Mon, Jan 4, 2010 at 01:26, Arjan van de Ven <arjan@infradead.org> wrote:
> On Mon, 4 Jan 2010 00:55:04 +0800
> Hui Zhu <teawater@gmail.com> wrote:
>>
>> It show which line make kernel die.
>>
>
> similar to scripts/markup_oops.pl already does ?
>
>
> --
> Arjan van de Ven ? ? ? ?Intel Open Source Technology Centre
> For development, discussion and tips for power savings,
> visit http://www.lesswatts.org
>
