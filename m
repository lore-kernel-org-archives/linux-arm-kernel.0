From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 18 Apr 2018 11:14:47 +0530
Subject: [PATCH v6 6/7] remoteproc/davinci: use the reset framework
In-Reply-To: <20180417173038.25510-7-brgl@bgdev.pl>
References: <20180417173038.25510-1-brgl@bgdev.pl>
 <20180417173038.25510-7-brgl@bgdev.pl>
Message-ID: <14b8384d-707d-42b7-b3ac-1ad914997a2e@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 April 2018 11:00 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Switch to using the reset framework instead of handcoded reset routines
> we used so far.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Looks good!

Reviewed-by: Sekhar Nori <nsekhar@ti.com>

This depends on DaVinci gaining common clock / reset framework support
though. I am guessing remoteproc maintainers will have to be reminded
when its safe to apply.

Thanks,
Sekhar
