From: harinikatakamlinux@gmail.com (Harini Katakam)
Date: Tue, 3 Jan 2017 16:18:58 +0530
Subject: [RFC PATCH net-next v4 1/2] macb: Add 1588 support in Cadence GEM.
In-Reply-To: <20170103102958.GC24780@localhost.localdomain>
References: <1481720175-12703-1-git-send-email-andrei.pistirica@microchip.com>
 <BN3PR07MB2516815EDE69ACDCE27F81A3C96F0@BN3PR07MB2516.namprd07.prod.outlook.com>
 <20170102113155.GA16373@localhost.localdomain>
 <0717c63b-2e29-9ad1-7f01-39817980933f@atmel.com>
 <20170102161359.GD3609@localhost.localdomain>
 <CAFcVECK1vt7Hu4tgSZ2+kKpMxoT-wpikMDq65HaxRv-EMgobHA@mail.gmail.com>
 <20170103102958.GC24780@localhost.localdomain>
Message-ID: <CAFcVECLqnOx9cJay_2j1QPwUpE5PrLYf28Sh43D-Otz_Z35Q3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

On Tue, Jan 3, 2017 at 3:59 PM, Richard Cochran
<richardcochran@gmail.com> wrote:
> On Tue, Jan 03, 2017 at 10:36:11AM +0530, Harini Katakam wrote:
>> I understand that it is not accurate - it is an initial version.
>
> Why do you say, "it is an initial version?"
>
> The Atmel device has this IP core burned in.  The core is hopelessly
> broken, and it cannot be fixed in SW either, so what is your point?
>

I'm sorry - I just meant that this was before many necessary
enhancements and fixes.
Newer SoCs including ZynqMP (for which the original series was sent)
have the descriptor based approach which is reliable.

Regards,
Harini
