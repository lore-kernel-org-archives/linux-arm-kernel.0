From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 13 Oct 2017 10:56:09 +0100
Subject: [PATCH/RFC 3/5] mfd: bd9571mwv: Allow DDR Backup Power register
 access
In-Reply-To: <CAMuHMdVZiaq40r0Su01n9C7oXR7i_QWmNhZtY7Udhy9gdYHVRA@mail.gmail.com>
References: <1507649178-31473-1-git-send-email-geert+renesas@glider.be>
 <1507649178-31473-4-git-send-email-geert+renesas@glider.be>
 <20171013085851.ljvgmyd6ei2tv5fw@dell>
 <CAMuHMdVZiaq40r0Su01n9C7oXR7i_QWmNhZtY7Udhy9gdYHVRA@mail.gmail.com>
Message-ID: <20171013095609.7ievqlwa2e4pnuge@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 13 Oct 2017, Geert Uytterhoeven wrote:

> Hi Lee,
> 
> On Fri, Oct 13, 2017 at 10:58 AM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Tue, 10 Oct 2017, Geert Uytterhoeven wrote:
> >
> >> Enable read/write access to the BD9571MWV_BKUP_MODE_CNT register, which
> >> is a.o. used to configure DDR Backup Power.
> >
> > a.o.?  That's a new one on me.
> 
> among(st) others

Please just write that instead. :)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
