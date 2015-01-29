From: bhelgaas@google.com (Bjorn Helgaas)
Date: Thu, 29 Jan 2015 08:35:35 -0600
Subject: [PATCH 06/16] ARM: cns3xxx: convert PCI to use generic config
 accesses
In-Reply-To: <m37fw6xga8.fsf@t19.piap.pl>
References: <1420857290-8373-1-git-send-email-robh@kernel.org>
 <1420857290-8373-7-git-send-email-robh@kernel.org>
 <m37fw6xga8.fsf@t19.piap.pl>
Message-ID: <CAErSpo56H5uUz4zOLk6j5m0Of8ZrZdc_bmNkHuGhEfx2WJvqeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 29, 2015 at 12:16 AM, Krzysztof Ha?asa <khalasa@piap.pl> wrote:
> Rob Herring <robh@kernel.org> writes:
>
>> Convert the cns3xxx PCI driver to use the generic config access functions.
>>
>> This changes accesses from __raw_readl/__raw_writel to readl/writel.
>>
>>  arch/arm/mach-cns3xxx/pcie.c | 52 +++++++++-----------------------------------
>
> This looks fine:
> Acked-by: Krzysztof Ha?asa <khalasa@piap.pl>

Thanks, I added your ack.
