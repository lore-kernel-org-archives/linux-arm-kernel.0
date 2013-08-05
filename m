From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 5 Aug 2013 09:14:50 +0800
Subject: [PATCH 1/2] pinctrl: imx: work around select input quirk
In-Reply-To: <20130804125452.GF18119@S2101-09.ap.freescale.net>
References: <1375330924-27384-1-git-send-email-shawn.guo@linaro.org>
 <20130801065147.GM8540@nchen-desktop>
 <CAAQ0ZWQajP49jM_0wqvqmuv19ZcSQ_1QUzgxfsBYzKU_5w0bMA@mail.gmail.com>
 <20130801083221.GA32696@nchen-desktop>
 <20130804125452.GF18119@S2101-09.ap.freescale.net>
Message-ID: <20130805011449.GA23614@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 04, 2013 at 08:54:54PM +0800, Shawn Guo wrote:
> Yes, we changed the prefix to simplify the DTS files for imx6q and
> imx6dl.
> 
> > 
> > Besides, please add comments for u16 *input_reg at struct imx_pin_group.
> 
> I'm not fond of documenting a workaround for a random quirky select
> input as a feature all over the files where input_reg is documented.
> It should be good enough to have it well documented at where the quirk
> is handled.

If the user finds "odd value" at xxx-pinfunc.h, how he knows what
it stands for? At least, It should be documented where the user
can find its meaning.

Best regards,
Peter
