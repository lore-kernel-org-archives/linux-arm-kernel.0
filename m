From: p.osciak@samsung.com (Pawel Osciak)
Date: Mon, 02 Aug 2010 12:32:20 +0200
Subject: [PATCH v3 1/8] ARM: Samsung: Add register definitions for Samsung
	S5P SoC camera interface
In-Reply-To: <00ba01cb2c8f$02fc8480$08f58d80$%kim@samsung.com>
References: <1279902083-21250-1-git-send-email-s.nawrocki@samsung.com>
	<1279902083-21250-2-git-send-email-s.nawrocki@samsung.com>
	<00ba01cb2c8f$02fc8480$08f58d80$%kim@samsung.com>
Message-ID: <003001cb322d$fc976b10$f5c64130$%osciak@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

>Kukjin Kim <kgene.kim@samsung.com> wrote:
>Sylwester Nawrocki wrote:
>>
>> Add register definitions for the camera interface/video postprocessor
>> contained in Samsung's S5P SoC series.
>>
>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> Reviewed-by: Pawel Osciak <p.osciak@samsung.com>
>> Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>  arch/arm/plat-samsung/include/plat/regs-fimc.h |  294
>> ++++++++++++++++++++++++
>>  1 files changed, 294 insertions(+), 0 deletions(-)
>>  create mode 100644 arch/arm/plat-samsung/include/plat/regs-fimc.h
>>
>> diff --git a/arch/arm/plat-samsung/include/plat/regs-fimc.h
>b/arch/arm/plat-
>> samsung/include/plat/regs-fimc.h
>> new file mode 100644
>> index 0000000..7f3141c
>> --- /dev/null
>> +++ b/arch/arm/plat-samsung/include/plat/regs-fimc.h
>> @@ -0,0 +1,294 @@
>> +/* arch/arm/plat-s5p/include/plat/regs-fimc.h
>> + *
>> + * Register definition file for Samsung Camera Interface (FIMC) driver

<snip>

>
>Looks ok...however, I'm still thinking whether really need all these
>definitions.
>
>Hmm...
>

Well, some of them are indeed unused, but it's not an uncommon practice in
kernel and might help future developers.


Best regards
--
Pawel Osciak
Linux Platform Group
Samsung Poland R&D Center
