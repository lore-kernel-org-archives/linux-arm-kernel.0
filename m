From: keescook@chromium.org (Kees Cook)
Date: Thu, 13 Sep 2018 14:40:12 -0700
Subject: [PATCH v2 0/8] add support for relative references in jump tables
In-Reply-To: <CAKv+Gu-O3mMJHH2P7L9anXeKZtEQYcN8Am4-3xkzAQSFWUN+=w@mail.gmail.com>
References: <20180702181145.4799-1-ard.biesheuvel@linaro.org>
 <20180704075923.GF3701@osiris>
 <CAKv+Gu-O3mMJHH2P7L9anXeKZtEQYcN8Am4-3xkzAQSFWUN+=w@mail.gmail.com>
Message-ID: <CAGXu5jJ9hD8-2ioAKdXKc8uV+OjRSJVUftd9rY9RfW7Tkor=kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 4, 2018 at 1:50 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 4 July 2018 at 09:59, Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
>> On Mon, Jul 02, 2018 at 08:11:37PM +0200, Ard Biesheuvel wrote:
>>> This series implements support for emitting the data structures associated
>>> with jump tables as 32-bit relative references instead of absolute
>>> references, which take up more space on builds that target 64-bit
>>> architectures, or implement self relocation [or both].
>>>
>>> This series enables it for arm64 and x86, although other architectures
>>> might benefit as well.
>>
>> Hello Ard,
>>
>> feel free to add the patch below which adds support for s390 to your series.
>>
>
> Thanks, I will incorporate it into v3 and beyond.

Just a quick status check! :) What're your plans for this series? I'd
still love to see it.

-Kees

-- 
Kees Cook
Pixel Security
