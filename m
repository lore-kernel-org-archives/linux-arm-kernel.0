From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 1 Jan 2010 15:56:24 +0800
Subject: [PATCH 2/2] pxa: enable L2 if present in XSC3
In-Reply-To: <771cded00912300105u1a31feb6t6465d47cd21aa900@mail.gmail.com>
References: <771cded00912292328j459b5218r64703d59165fe98f@mail.gmail.com>
	<f17812d70912300050p24c0fb2ayd6f68ffc01a67529@mail.gmail.com>
	<771cded00912300105u1a31feb6t6465d47cd21aa900@mail.gmail.com>
Message-ID: <f17812d70912312356t43c319cew45999987a1b22844@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 30, 2009 at 5:05 PM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> On Wed, Dec 30, 2009 at 3:50 AM, Eric Miao <eric.y.miao@gmail.com> wrote:
>
>>>
>>> Check whether L2 is present or not in XSC3. If it's present, enable L2
>>> immediately.
>>>
>>> Disabling L2 after L2 is enabled that would result in unpredicatable behavior
>>> of XSC3 processor.
>>>
>>
>> You may want to enclose this with #ifdef CONFIG_CACHE_XSC3L2 .. #endif
>> at least, to allow L2 to remain disabled even if L2 is present.
>>
>
> Updated this patch.

Applied.
