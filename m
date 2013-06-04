From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Tue, 4 Jun 2013 11:56:57 +0200
Subject: [PATCH 4/5] ARM: ux500: Provide auxdata to ux500 ASoC driver
In-Reply-To: <CACRpkda8h_zewd2M7QzvoLn15iDEUv8XYCGqro62chiCcYaM8Q@mail.gmail.com>
References: <1369920465-13905-1-git-send-email-fabio.baltieri@linaro.org>
 <1369920465-13905-5-git-send-email-fabio.baltieri@linaro.org>
 <CACRpkda8h_zewd2M7QzvoLn15iDEUv8XYCGqro62chiCcYaM8Q@mail.gmail.com>
Message-ID: <20130604095657.GA9581@balto.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 04, 2013 at 11:03:41AM +0200, Linus Walleij wrote:
> On Thu, May 30, 2013 at 3:27 PM, Fabio Baltieri
> <fabio.baltieri@linaro.org> wrote:
> 
> > Ux500 ASoC driver is expected to have a specific device name to get
> > clock resources correctly.  This patch provides the necessary
> > OF_DEV_AUXDATA to match the name in DT and non-DT cases.
> >
> > Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
> 
> Patch applied to my ux500-devicetree branch after some rebasing.

Thanks!  I saw that a lot patches are stacking up in the tree, do you
plan to send an intermediate pull request to get these on
arm-soc/for-next (and linux-next)?

Thanks,
Fabio

> 
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Fabio Baltieri
