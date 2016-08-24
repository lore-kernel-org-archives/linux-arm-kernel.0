From: daniel@zonque.org (Daniel Mack)
Date: Wed, 24 Aug 2016 10:35:52 +0200
Subject: [PATCH v3 0/2] AM335x-ICE: Add support for rotary switch
In-Reply-To: <20160824075859.30979-1-vigneshr@ti.com>
References: <20160824075859.30979-1-vigneshr@ti.com>
Message-ID: <c5385d42-14e4-d5ca-370e-5b04e37d873d@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08/24/2016 09:58 AM, Vignesh R wrote:
> This series adds support for rotary-switch on AM335x-ICE that is
> connected to TI PCA9536 I2C GPIO expander.
> First patch adds new generic driver to read status of group of GPIO
> lines and report the value as an input event. The second patch adds DT
> entries for the same.
> 
> v2: https://lkml.org/lkml/2016/8/23/111
> v1: https://lkml.org/lkml/2016/8/12/7

Is there a reason why the rotary-encoder driver cannot handle this?
Commit 7dde4e74744 ("Input: rotary-encoder - support more than 2 gpios
as input") added support for that mode AFAIU.

I copied the author of that patch to have a look.


Thanks,
Daniel
