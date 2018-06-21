From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 21 Jun 2018 16:22:24 +0530
Subject: [PATCH v7 0/4] ARM: davinci: complete the conversion to using the
 reset framework
In-Reply-To: <20180621073706.22812-1-brgl@bgdev.pl>
References: <20180621073706.22812-1-brgl@bgdev.pl>
Message-ID: <9ec10627-49a5-07ad-8c9d-5ac873096cc0@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartosz,

On Thursday 21 June 2018 01:07 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> These are the remaining patches that still need to be merged in order
> to complete the conversion of the davinci dsp driver to using the reset
> framework.
> 
> They apply on top of v4.18-rc1 with David Lechner's remaining patches
> merged.

Series looks good to me.

To preserve bisect, shouldn't the order of applying be patch #3, #4, #1
and #2 ?

Given the dependencies and to preserve bisect its easiest if I take the
series with acks from remoteproc and clock maintainers.

Open to other suggestions as well.

Thanks,
Sekhar
