From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 17 Jan 2013 17:16:16 -0800
Subject: [PATCH v7] usb: phy: samsung: Add support to set pmu isolation
In-Reply-To: <1358230225-2770-1-git-send-email-gautam.vivek@samsung.com>
References: <CAFp+6iE7zEJ7E_pRCOYz5mQqbk-MFE6Hwr02pRRT1yP+X3z7kQ@mail.gmail.com>
 <1358230225-2770-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <003001cdf519$6d21c690$476553b0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vivek Gautam wrote:
> 
> Adding support to parse device node data in order to get
> required properties to set pmu isolation for usb-phy.
> 
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Reviewed-by: Doug Anderson <dianders@chromium.org>

This looks good to me,
Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Vivek, could you please re-send following in one series?
- [PATCH v9 1/2] usb: phy: samsung: Introducing usb phy driver for hsotg
- [PATCH v8 2/2] usb: s3c-hsotg: Adding phy driver support

As I know, this should be applied on top of above patches.

Thanks.

- Kukjin
