From: chris.brand@broadcom.com (Chris Brand)
Date: Mon, 9 May 2016 15:27:49 -0700
Subject: [PATCH 3/6] docs: Document BCM23550 bindings
In-Reply-To: <20160509194115.GA11594@rob-hp-laptop>
References: <1462481334-8943-1-git-send-email-chris.brand@broadcom.com>
 <1462481334-8943-4-git-send-email-chris.brand@broadcom.com>
 <20160509194115.GA11594@rob-hp-laptop>
Message-ID: <CAMsMSK-da2GstXrrYVpoJh2fo-Gi70gD7WFxi8TM9M=Zmqu1Rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 9, 2016 at 12:41 PM, Rob Herring <robh@kernel.org> wrote:
> On Thu, May 05, 2016 at 01:48:51PM -0700, Chris Brand wrote:
>> Add binding document for Broadcom BCM23550 SoC.
[...]
>> +The enable method is specified by defining the following required
>> +properties in the "cpu" device tree node:
>> +  - enable-method = "brcm,bcm23550-cpu-method";
>
> "-cpu-method" is a bit redundant. brcm,bc23550 is probably sufficient.

Fair enough. Thanks, Rob!

Chris
