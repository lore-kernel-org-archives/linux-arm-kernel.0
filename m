From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 16 May 2017 17:27:34 -0300
Subject: [PATCH] ARM: dts: imx7d-pico: Add initial support
In-Reply-To: <1494955971-5006-1-git-send-email-vanessa.maegima@nxp.com>
References: <1494955971-5006-1-git-send-email-vanessa.maegima@nxp.com>
Message-ID: <CAOMZO5BNZ_fm3wxrobR-uD5uDBbVgRTjhjJ4nNvZC6qjBjr9yA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vanessa,

On Tue, May 16, 2017 at 2:32 PM, Vanessa Maegima
<vanessa.maegima@nxp.com> wrote:

> +&usdhc3 {
> +       pinctrl-names = "default", "state_100mhz", "state_200mhz";

As you are using only the 'default' entry, you could remove the other ones.
