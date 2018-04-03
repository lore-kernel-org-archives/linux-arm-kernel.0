From: ssuloev@orpaltech.com (Sergey Suloev)
Date: Tue, 3 Apr 2018 13:27:57 +0300
Subject: [PATCH 5/6] spi: sun4i: introduce register set/unset helpers
In-Reply-To: <20180403081458.lyilg3yu3n2e54fd@flea>
References: <20180329185907.27281-1-ssuloev@orpaltech.com>
 <20180329185907.27281-6-ssuloev@orpaltech.com>
 <20180403081458.lyilg3yu3n2e54fd@flea>
Message-ID: <8edccc63-9729-ff4c-b272-1916e7794bc7@orpaltech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2018 11:14 AM, Maxime Ripard wrote:
> On Thu, Mar 29, 2018 at 09:59:06PM +0300, Sergey Suloev wrote:
>> Two helper functions were added in order to update
>> registers easily.
>>
>> Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>
> I'm not really sure what's easier about this one.
>
> Maxime
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

well, just seems more readable vs doing "read, or, write" every time
