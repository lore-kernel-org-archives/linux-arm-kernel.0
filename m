From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 11 Dec 2017 12:38:18 +0100
Subject: [PATCH 03/20] ARM: dts: aspeed-g4: Correct VUART IRQ number
In-Reply-To: <CACPK8XfSxxVFT7y6M17LZhVO0GHuL1L=6KET75Qojg8rpgD9iw@mail.gmail.com>
References: <20171211050704.20621-1-joel@jms.id.au>
 <20171211050704.20621-4-joel@jms.id.au>
 <CAK8P3a2psgOYZEgO8O3H_xxpDTNd=ESJpSf4bs9kf0nPvKYqtQ@mail.gmail.com>
 <CACPK8XfSxxVFT7y6M17LZhVO0GHuL1L=6KET75Qojg8rpgD9iw@mail.gmail.com>
Message-ID: <CAK8P3a0kryZNKwzZ-57XMiJc9=7qcFpU6J0sCvbg9VGAQ_LHYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 11, 2017 at 11:44 AM, Joel Stanley <joel@jms.id.au> wrote:
> On Mon, Dec 11, 2017 at 6:28 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Mon, Dec 11, 2017 at 6:06 AM, Joel Stanley <joel@jms.id.au> wrote:
>>> This should have always been 8.
>>>
>>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>>
>> As this is a bugfix, should we backport it to stable kernels? When you
>> fix a bug,
>> I generally recommend including a 'Fixes' tag with the commit ID of the patch
>> that introduced the problem, and either a 'Cc: stable at vger.kernel.org' tag
>> if you want it backported, or an explanation in the changelog why it should
>> not get backported. This really helps Greg and the other stable maintainers
>> trying to make a decision what to backport and what not.
>
> We could do this, and I generally follow the practice of adding Fixes
> tags. I hadn't because without an upstream clock driver, the Aspeed
> port is not usable by anyone without making modifications. We're
> really depending on getting that code merged.
>
> I will send it as a fix to 4.15. Do you mind taking individual patches
> for the arm dt tree, or would you prefer a pull request?

For bugfixes, we don't distinguish between DT and other fixes. If it's
a single patch, a pull request works just as well as a emailed patch,
your choice.

      Arnd
