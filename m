From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Tue, 10 Apr 2018 15:34:57 -0300
Subject: [PATCH v8 2/3] mtd: spi-nor: add rockchip serial flash controller
 driver
In-Reply-To: <1518092327-3827-1-git-send-email-andy.yan@rock-chips.com>
References: <1518091958-3672-1-git-send-email-andy.yan@rock-chips.com>
 <1518092327-3827-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <CAAEAJfCYm4Z20x8PdU3uHh_0BExTCAoOy5Aq=ZXWLJKaB1C9kQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

Just a very minor nit.

On 8 February 2018 at 09:18, Andy Yan <andy.yan@rock-chips.com> wrote:
[..]
> +
> +static int get_if_type(struct rockchip_sfc *sfc, enum spi_nor_protocol proto)
> +{

I understand that this got copy-pasted from some other driver,
but please change this function name to something like
rockchip_sfc_get_if_type().

Thanks,
Eze
