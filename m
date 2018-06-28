From: andreyknvl@google.com (Andrey Konovalov)
Date: Thu, 28 Jun 2018 20:26:39 +0200
Subject: [PATCH v4 00/17] khwasan: kernel hardware assisted address
 sanitizer
In-Reply-To: <20180627181138.14c9b66e13b8778506205f89@linux-foundation.org>
References: <cover.1530018818.git.andreyknvl@google.com>
 <20180627160800.3dc7f9ee41c0badbf7342520@linux-foundation.org>
 <CAN=P9pivApAo76Kjc0TUDE0kvJn0pET=47xU6e=ioZV2VqO0Rg@mail.gmail.com>
 <CAEZpscCcP6=O_OCqSwW8Y6u9Ee99SzWN+hRcgpP2tK=OEBFnNw@mail.gmail.com>
 <20180627181138.14c9b66e13b8778506205f89@linux-foundation.org>
Message-ID: <CAAeHK+wg35W6D3Cat7w8kqV+9fB6dKmnCUuUrZP_tz5=vKk+0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2018 at 3:11 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Wed, 27 Jun 2018 17:59:00 -0700 Vishwath Mohan <vishwath@google.com> wrote:
>> Yeah, I can confirm that it's an issue. Like Kostya mentioned, I don't have
>> data on-hand, but anecdotally both ASAN and KASAN have proven problematic
>> to enable for environments that don't tolerate the increased memory
>> pressure well. This includes,
>> (a) Low-memory form factors - Wear, TV, Things, lower-tier phones like Go
>> (c) Connected components like Pixel's visual core
>> <https://www.blog.google/products/pixel/pixel-visual-core-image-processing-and-machine-learning-pixel-2/>
>>
>>
>> These are both places I'd love to have a low(er) memory footprint option at
>> my disposal.
>
> Thanks.
>
> It really is important that such information be captured in the
> changelogs.  In as much detail as can be mustered.

I'll add it to the changelog in v5. Thanks!
