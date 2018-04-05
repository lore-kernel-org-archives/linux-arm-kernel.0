From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 5 Apr 2018 13:58:12 +0200
Subject: [PATCH v3 1/5] io: define several IO & PIO barrier types for the
 asm-generic version
In-Reply-To: <e2290e35d919d46a6d45b0e47abb866e@codeaurora.org>
References: <1522886301-25955-1-git-send-email-okaya@codeaurora.org>
 <CAK8P3a0Noun+8AaRUcMdOX09KXxFXZxfcyUgJnezPkS2gVkg6w@mail.gmail.com>
 <e2290e35d919d46a6d45b0e47abb866e@codeaurora.org>
Message-ID: <CAK8P3a2ovkToy5Yv=15_tyM8GUoZfSJ2QdhGev=fNSRCAj9bCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 5, 2018 at 1:48 PM,  <okaya@codeaurora.org> wrote:
> On 2018-04-05 03:00, Arnd Bergmann wrote:

>> The other four patches look perfect already.  What's the timing we need
>> for
>> these patches? Are they 4.18 material, or do we need them in 4.17 and
>> stable kernels to work around known bugs?
>
>
> I was hoping to get all arch stuff in for 4.17.
>
> Driver developers started removing redundant wmb().

Ok, so 4.17 but no stable backports then.

     Arnd
