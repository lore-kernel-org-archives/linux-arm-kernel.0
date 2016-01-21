From: ivo.g.dimitrov.75@gmail.com (Ivaylo Dimitrov)
Date: Thu, 21 Jan 2016 09:58:08 +0200
Subject: [PATCH] ARM: dts: omap3-n900: Allow gpio keys to be disabled
In-Reply-To: <1452447990-22775-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <1452447990-22775-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Message-ID: <56A08F90.1000208@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping

On 10.01.2016 19:46, Ivaylo Dimitrov wrote:
> Add linux,can-disable; to all gpios exported from gpio-keys driver, so
> userspace can disable them
>
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> ---
>   arch/arm/boot/dts/omap3-n900.dts | 6 ++++++
>   1 file changed, 6 insertions(+)
>
