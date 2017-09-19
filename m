From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 19 Sep 2017 17:11:17 -0300
Subject: [PATCH v4 4/6] ARM: dts: imx6dl-icore: Add LVDS support
In-Reply-To: <CAMty3ZCQP5vnrU5MSzRFwRS+vS9a_ULt3sNB07BOHv0dCton0w@mail.gmail.com>
References: <1505121145-9507-1-git-send-email-jteki@openedev.com>
 <1505121145-9507-4-git-send-email-jteki@openedev.com>
 <CAOMZO5B0RAjdupLSe=S+tDEA-hpf-Si_4qjkcKC_ECX86PLScQ@mail.gmail.com>
 <CAMty3ZD3od1LXKai=kwq8hxGsa3EWcjQx5gyBtZvCM5ccC34ZQ@mail.gmail.com>
 <CAOMZO5C+DXAQu=2OUAquB2AKn8dOzadoPsdGD05hXAUBdTnYjQ@mail.gmail.com>
 <CAMty3ZCQP5vnrU5MSzRFwRS+vS9a_ULt3sNB07BOHv0dCton0w@mail.gmail.com>
Message-ID: <CAOMZO5CwFV454Vt-LMMmjaJPatHXuONKshOPmJQVzR_mKuw1Aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 19, 2017 at 4:21 PM, Jagan Teki <jagan@amarulasolutions.com> wrote:

> Yes, it is working..but need to understand how these respective
> timings were calculated(because I need to add few more) . I tried this
> supported ampire but couldn't get the data-sheet. Please point me if
> you find any details.

I don't have information about this panel.

Maybe you could check with the author from commit:

commit 1c550fa193d08920255240743f57731d4d57cd4d
Author: Philipp Zabel <p.zabel@pengutronix.de>
Date:   Wed Feb 11 18:50:09 2015 +0100

    drm/panel: Add support for Ampire AM-800480R3TMQW-A1H 800x480 7" panel

    This adds support for the AM-800480R3TMQW-A1H 7" 800x480 panel to the
    DRM simple panel driver.

    Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
    Signed-off-by: Thierry Reding <treding@nvidia.com>

via dri-devel at lists.freedesktop.org list.
