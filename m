From: pramod.gurav@linaro.org (Pramod Gurav)
Date: Mon, 30 May 2016 18:50:47 +0530
Subject: [PATCH] usb: echi-hcd: Add ehci_setup check before echi_shutdown
In-Reply-To: <1463652776-30456-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1463652776-30456-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <CANYu_0vK8-oEL-QrHH196DnEy+5qSYEqm1s1P4FXkDUJWOJH0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 May 2016 at 15:42, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:

<snip>

> Fixes 4bb3cad7125b ("usb: host: ehci-msm: Register usb shutdown function")
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Was seeing this crash while doing a reboot on db410c which is fixed
with this patch:

Tested-by: Pramod Gurav <pramod.gurav@linaro.org>
