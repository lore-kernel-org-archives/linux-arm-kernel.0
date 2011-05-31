From: kishorek.kadiyala@gmail.com (Kishore Kadiyala)
Date: Tue, 31 May 2011 19:34:45 +0530
Subject: [PATCH 1/2] ARM: OMAP4: MMC: increase delay for pbias
In-Reply-To: <1306765534-20103-2-git-send-email-balajitk@ti.com>
References: <1306765534-20103-1-git-send-email-balajitk@ti.com>
	<1306765534-20103-2-git-send-email-balajitk@ti.com>
Message-ID: <BANLkTimkrYo-3+Xf9DV+6YLRdhCGZ0MOzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 30, 2011 at 7:55 PM, Balaji T K <balajitk@ti.com> wrote:
> 4 micro seconds is not enough for PBIAS if MMC regulator is
> enabled from MMC regulator OFF.
> Increase the delay for PBIAS to stabilize.
> Wait for PBIAS and timeout if not.
>
> Resolves MMC/SD failure on OMAP4
> "Pbias Voltage is not same as LDO"
>
> Signed-off-by: Balaji T K <balajitk@ti.com>

Acked-by:  Kishore Kadiyala <kishore.kadiyala@ti.com>

<snip>
