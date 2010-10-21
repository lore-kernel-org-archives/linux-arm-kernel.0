From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 21 Oct 2010 11:02:02 -0200
Subject: [patch v2 07/10] efikamx: add support for power key
In-Reply-To: <20101021104005.796793454@rtp-net.org>
References: <20101021103855.115653951@rtp-net.org>
	<20101021104005.796793454@rtp-net.org>
Message-ID: <AANLkTimWHeibb47NfQ7UJoawi5QN2gt1FjpvKy0S82LH@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,

On Thu, Oct 21, 2010 at 8:39 AM, Arnaud Patard
<arnaud.patard@rtp-net.org> wrote:
> This patch adds support for power key button of the efika mx. It's connected
> on ?GPIO 3 31.

Here you mention GPIO 3 31

> +#define EFIKAMX_POWER_KEY ? ? ?(1*32 + 31)

,but here you define it as GPIO 2 31

Regards,

Fabio Estevam
