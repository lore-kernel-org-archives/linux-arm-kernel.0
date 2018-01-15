From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 15 Jan 2018 15:54:31 +0100
Subject: [PATCH v2] ARM: dts: rename oxnas dts files
In-Reply-To: <CAK8P3a1NUww8pGWr=gvxSDk4p7Emoq9NJyGfs8N86bU_sqgnpQ@mail.gmail.com>
References: <20180113173553.GA30727@makrotopia.org>
 <CAK8P3a1NUww8pGWr=gvxSDk4p7Emoq9NJyGfs8N86bU_sqgnpQ@mail.gmail.com>
Message-ID: <05179c69-5878-f8ec-76f1-00de21e1b75d@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/01/2018 15:45, Arnd Bergmann wrote:
> On Sat, Jan 13, 2018 at 6:35 PM, Daniel Golle <daniel@makrotopia.org> wrote:
>> Other platforms' device-tree files start with a platform prefix, such as
>> sun7i-a20-*.dts or at91-*.dts.
>> This naming scheme turns out to be handy when using multi-platform build
>> systems such as OpenWrt.
>> Prepend oxnas files with their platform prefix to comply with the naming
>> scheme already used for most other platforms.
>>
>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> 
> There are few changes to oxnas in general, and Neil doesn't appear to be around
> to ask at the moment.
> I assume he doesn't mind me picking it up into next/dt directly.
> 
> Merged now, thanks,
> 
>         Arnd
> 


Hi Daniel,

Thanks for pushing this change, these a low-priority supported devices, OK to rename them.

(I must no forget to changes my test scripts, or I will get a huge headache)

Arnd, thanks for taking this directly.

Neil
