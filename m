From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 30 Mar 2018 17:38:35 +0800
Subject: [PATCH v3 3/3] arm64: allwinner: a64: bananapi-m64: add usb otg
In-Reply-To: <1513011400-4120-3-git-send-email-jagan@amarulasolutions.com>
References: <1513011400-4120-1-git-send-email-jagan@amarulasolutions.com>
 <1513011400-4120-3-git-send-email-jagan@amarulasolutions.com>
Message-ID: <CAGb2v673V4-jU2WLZA2rJ9+TAU8ehuNzXw+P+PHQeRu3nXC+AQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 12, 2017 at 12:56 AM, Jagan Teki <jagan@amarulasolutions.com> wrote:
> Add usb otg support for bananapi-m64 board,
> - USB-ID connected with PH9
> - USB-DRVVBUS controlled by N_VBUSEN pin from PMIC
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v3:
> - Move the position of reg_drivevbus as per binding documentation.

The label dereferences should be ordered in alphabetical order of
the label names.

Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
