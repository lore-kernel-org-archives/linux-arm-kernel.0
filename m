From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Mar 2017 18:00:30 +0100
Subject: [PATCH 01/15] ARM: dts: alpine: fix PCIe node name
In-Reply-To: <20170322080137.st3osq5ckfis6uwz@kwain>
References: <20170322020313.24338-1-robh@kernel.org>
 <20170322080137.st3osq5ckfis6uwz@kwain>
Message-ID: <CAK8P3a2WOeNrz3J8vO+n+rhwn3N_vdOswZ0NMmYrdNvmkD8obQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 9:01 AM, Antoine Tenart
<antoine.tenart@free-electrons.com> wrote:
> Hi Rob,
>
> On Tue, Mar 21, 2017 at 09:02:59PM -0500, Rob Herring wrote:
>> PCIe bridges should have a node name of 'pcie'.
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>
> Acked-by: Antoine Tenart <antoine.tenart@free-electrons.com>
>
> This can go through arm-soc directly. If not I'll take it.
> Thanks!

I have a mild preference for this kind of patch to get picked up by
platform maintainers.

Rob, once replies stop coming in, please send a pull request for anything
that did not get picked up by anyone else.

     Arnd
