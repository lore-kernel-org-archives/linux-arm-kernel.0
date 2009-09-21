From: kirill@shutemov.name (Kirill A. Shutemov)
Date: Mon, 21 Sep 2009 14:30:52 +0300
Subject: [PATCH v3 1/2] ARM: Pass IFSR register to do_PrefetchAbort()
In-Reply-To: <4AB74956.8070708@nokia.com>
References: <2f6c0105e623b9134adbb2e849e8074722903fb9.1253530731.git.kirill@shutemov.name>
	<4AB74956.8070708@nokia.com>
Message-ID: <cc557aab0909210430i6f016c60s89f276b662f01501@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 21, 2009 at 12:37 PM, Aaro Koskinen <aaro.koskinen@nokia.com> wrote:
> Hi,
>
> Kirill A. Shutemov wrote:
>>
>> It needed for proper prefetch abort handling on ARMv7.
>>
>> Instruction fault status register (IFSR) was introduced on ARMv7.
>
> According to the ARMv7-AR reference manual it's available in ARMv6
> (see chapter G.7).

You are right. I'll fix my patch.
